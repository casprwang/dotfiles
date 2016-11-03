[
  ColorBuffer, ColorSearch,
  Palette, ColorMarkerElement, VariablesCollection,
  PathsLoader, PathsScanner,
  Emitter, CompositeDisposable, Range,
  SERIALIZE_VERSION, SERIALIZE_MARKERS_VERSION, THEME_VARIABLES, ATOM_VARIABLES,
  scopeFromFileName,
  minimatch
] = []

compareArray = (a,b) ->
  return false if not a? or not b?
  return false unless a.length is b.length
  return false for v,i in a when v isnt b[i]
  return true

module.exports =
class ColorProject
  @deserialize: (state) ->
    unless SERIALIZE_VERSION?
      {SERIALIZE_VERSION, SERIALIZE_MARKERS_VERSION} = require './versions'

    markersVersion = SERIALIZE_MARKERS_VERSION
    markersVersion += '-dev' if atom.inDevMode() and atom.project.getPaths().some (p) -> p.match(/\/pigments$/)

    if state?.version isnt SERIALIZE_VERSION
      state = {}

    if state?.markersVersion isnt markersVersion
      delete state.variables
      delete state.buffers

    if not compareArray(state.globalSourceNames, atom.config.get('pigments.sourceNames')) or not compareArray(state.globalIgnoredNames, atom.config.get('pigments.ignoredNames'))
      delete state.variables
      delete state.buffers
      delete state.paths

    new ColorProject(state)

  constructor: (state={}) ->
    {Emitter, CompositeDisposable, Range} = require 'atom' unless Emitter?
    VariablesCollection ?= require './variables-collection'

    {
      @includeThemes, @ignoredNames, @sourceNames, @ignoredScopes, @paths, @searchNames, @ignoreGlobalSourceNames, @ignoreGlobalIgnoredNames, @ignoreGlobalIgnoredScopes, @ignoreGlobalSearchNames, @ignoreGlobalSupportedFiletypes, @supportedFiletypes, variables, timestamp, buffers
    } = state

    @emitter = new Emitter
    @subscriptions = new CompositeDisposable
    @colorBuffersByEditorId = {}
    @bufferStates = buffers ? {}

    @variableExpressionsRegistry = require './variable-expressions'
    @colorExpressionsRegistry = require './color-expressions'

    if variables?
      @variables = atom.deserializers.deserialize(variables)
    else
      @variables = new VariablesCollection

    @subscriptions.add @variables.onDidChange (results) =>
      @emitVariablesChangeEvent(results)

    @subscriptions.add atom.config.observe 'pigments.sourceNames', =>
      @updatePaths()

    @subscriptions.add atom.config.observe 'pigments.ignoredNames', =>
      @updatePaths()

    @subscriptions.add atom.config.observe 'pigments.ignoredBufferNames', (@ignoredBufferNames) =>
      @updateColorBuffers()

    @subscriptions.add atom.config.observe 'pigments.ignoredScopes', =>
      @emitter.emit('did-change-ignored-scopes', @getIgnoredScopes())

    @subscriptions.add atom.config.observe 'pigments.supportedFiletypes', =>
      @updateIgnoredFiletypes()
      @emitter.emit('did-change-ignored-scopes', @getIgnoredScopes())

    @subscriptions.add atom.config.observe 'pigments.markerType', (type) ->
      if type?
        ColorMarkerElement ?= require './color-marker-element'
        ColorMarkerElement.setMarkerType(type)

    @subscriptions.add atom.config.observe 'pigments.ignoreVcsIgnoredPaths', =>
      @loadPathsAndVariables()

    @subscriptions.add atom.config.observe 'pigments.sassShadeAndTintImplementation', =>
      @colorExpressionsRegistry.emitter.emit 'did-update-expressions', {
        registry: @colorExpressionsRegistry
      }

    svgColorExpression = @colorExpressionsRegistry.getExpression('pigments:named_colors')
    @subscriptions.add atom.config.observe 'pigments.filetypesForColorWords', (scopes) =>
      svgColorExpression.scopes = scopes ? []
      @colorExpressionsRegistry.emitter.emit 'did-update-expressions', {
        name: svgColorExpression.name
        registry: @colorExpressionsRegistry
      }

    @subscriptions.add @colorExpressionsRegistry.onDidUpdateExpressions ({name}) =>
      return if not @paths? or name is 'pigments:variables'
      @variables.evaluateVariables @variables.getVariables(), =>
        colorBuffer.update() for id, colorBuffer of @colorBuffersByEditorId

    @subscriptions.add @variableExpressionsRegistry.onDidUpdateExpressions =>
      return unless @paths?
      @reloadVariablesForPaths(@getPaths())

    @timestamp = new Date(Date.parse(timestamp)) if timestamp?

    @updateIgnoredFiletypes()

    @initialize() if @paths?
    @initializeBuffers()

  onDidInitialize: (callback) ->
    @emitter.on 'did-initialize', callback

  onDidDestroy: (callback) ->
    @emitter.on 'did-destroy', callback

  onDidUpdateVariables: (callback) ->
    @emitter.on 'did-update-variables', callback

  onDidCreateColorBuffer: (callback) ->
    @emitter.on 'did-create-color-buffer', callback

  onDidChangeIgnoredScopes: (callback) ->
    @emitter.on 'did-change-ignored-scopes', callback

  onDidChangePaths: (callback) ->
    @emitter.on 'did-change-paths', callback

  observeColorBuffers: (callback) ->
    callback(colorBuffer) for id,colorBuffer of @colorBuffersByEditorId
    @onDidCreateColorBuffer(callback)

  isInitialized: -> @initialized

  isDestroyed: -> @destroyed

  initialize: ->
    return Promise.resolve(@variables.getVariables()) if @isInitialized()
    return @initializePromise if @initializePromise?
    @initializePromise = new Promise((resolve) =>
      @variables.onceInitialized(resolve)
    )
    .then =>
      @loadPathsAndVariables()
    .then =>
      @includeThemesVariables() if @includeThemes
    .then =>
      @initialized = true

      variables = @variables.getVariables()
      @emitter.emit 'did-initialize', variables
      variables

  destroy: ->
    return if @destroyed

    PathsScanner ?= require './paths-scanner'

    @destroyed = true

    PathsScanner.terminateRunningTask()

    buffer.destroy() for id,buffer of @colorBuffersByEditorId
    @colorBuffersByEditorId = null

    @subscriptions.dispose()
    @subscriptions = null

    @emitter.emit 'did-destroy', this
    @emitter.dispose()

  reload: ->
    @initialize().then =>
      @variables.reset()
      @paths = []
      @loadPathsAndVariables()
    .then =>
      if atom.config.get('pigments.notifyReloads')
        atom.notifications.addSuccess("Pigments successfully reloaded", dismissable: atom.config.get('pigments.dismissableReloadNotifications'), description: """Found:
        - **#{@paths.length}** path(s)
        - **#{@getVariables().length}** variables(s) including **#{@getColorVariables().length}** color(s)
        """)
      else
        console.log("""Found:
        - #{@paths.length} path(s)
        - #{@getVariables().length} variables(s) including #{@getColorVariables().length} color(s)
        """)
    .catch (reason) ->
      detail = reason.message
      stack = reason.stack
      atom.notifications.addError("Pigments couldn't be reloaded", {detail, stack, dismissable: true})
      console.error reason

  loadPathsAndVariables: ->
    destroyed = null

    @loadPaths().then ({dirtied, removed}) =>
      # We can find removed files only when there's already paths from
      # a serialized state
      if removed.length > 0
        @paths = @paths.filter (p) -> p not in removed
        @deleteVariablesForPaths(removed)

      # There was serialized paths, and the initialization discovered
      # some new or dirty ones.
      if @paths? and dirtied.length > 0
        @paths.push path for path in dirtied when path not in @paths

        # There was also serialized variables, so we'll rescan only the
        # dirty paths
        if @variables.length
          dirtied
        # There was no variables, so it's probably because the markers
        # version changed, we'll rescan all the files
        else
          @paths
      # There was no serialized paths, so there's no variables neither
      else unless @paths?
        @paths = dirtied
      # Only the markers version changed, all the paths from the serialized
      # state will be rescanned
      else unless @variables.length
        @paths
      # Nothing changed, there's no dirty paths to rescan
      else
        []
    .then (paths) =>
      @loadVariablesForPaths(paths)
    .then (results) =>
      @variables.updateCollection(results) if results?

  findAllColors: ->
    ColorSearch ?= require './color-search'

    patterns = @getSearchNames()
    new ColorSearch
      sourceNames: patterns
      project: this
      ignoredNames: @getIgnoredNames()
      context: @getContext()

  setColorPickerAPI: (@colorPickerAPI) ->

  ##    ########  ##     ## ######## ######## ######## ########   ######
  ##    ##     ## ##     ## ##       ##       ##       ##     ## ##    ##
  ##    ##     ## ##     ## ##       ##       ##       ##     ## ##
  ##    ########  ##     ## ######   ######   ######   ########   ######
  ##    ##     ## ##     ## ##       ##       ##       ##   ##         ##
  ##    ##     ## ##     ## ##       ##       ##       ##    ##  ##    ##
  ##    ########   #######  ##       ##       ######## ##     ##  ######

  initializeBuffers: ->
    @subscriptions.add atom.workspace.observeTextEditors (editor) =>
      editorPath = editor.getPath()
      return if not editorPath? or @isBufferIgnored(editorPath)

      buffer = @colorBufferForEditor(editor)
      if buffer?
        bufferElement = atom.views.getView(buffer)
        bufferElement.attach()

  hasColorBufferForEditor: (editor) ->
    return false if @destroyed or not editor?
    @colorBuffersByEditorId[editor.id]?

  colorBufferForEditor: (editor) ->
    return if @destroyed
    return unless editor?

    ColorBuffer ?= require './color-buffer'

    if @colorBuffersByEditorId[editor.id]?
      return @colorBuffersByEditorId[editor.id]

    if @bufferStates[editor.id]?
      state = @bufferStates[editor.id]
      state.editor = editor
      state.project = this
      delete @bufferStates[editor.id]
    else
      state = {editor, project: this}

    @colorBuffersByEditorId[editor.id] = buffer = new ColorBuffer(state)

    @subscriptions.add subscription = buffer.onDidDestroy =>
      @subscriptions.remove(subscription)
      subscription.dispose()
      delete @colorBuffersByEditorId[editor.id]

    @emitter.emit 'did-create-color-buffer', buffer

    buffer

  colorBufferForPath: (path) ->
    for id,colorBuffer of @colorBuffersByEditorId
      return colorBuffer if colorBuffer.editor.getPath() is path

  updateColorBuffers: ->
    for id, buffer of @colorBuffersByEditorId
      if @isBufferIgnored(buffer.editor.getPath())
        buffer.destroy()
        delete @colorBuffersByEditorId[id]

    try
      if @colorBuffersByEditorId?
        for editor in atom.workspace.getTextEditors()
          continue if @hasColorBufferForEditor(editor) or @isBufferIgnored(editor.getPath())

          buffer = @colorBufferForEditor(editor)
          if buffer?
            bufferElement = atom.views.getView(buffer)
            bufferElement.attach()

    catch e
      console.log e

  isBufferIgnored: (path) ->
    minimatch ?= require 'minimatch'

    path = atom.project.relativize(path)
    sources = @ignoredBufferNames ? []
    return true for source in sources when minimatch(path, source, matchBase: true, dot: true)
    false

  ##    ########     ###    ######## ##     ##  ######
  ##    ##     ##   ## ##      ##    ##     ## ##    ##
  ##    ##     ##  ##   ##     ##    ##     ## ##
  ##    ########  ##     ##    ##    #########  ######
  ##    ##        #########    ##    ##     ##       ##
  ##    ##        ##     ##    ##    ##     ## ##    ##
  ##    ##        ##     ##    ##    ##     ##  ######

  getPaths: -> @paths?.slice()

  appendPath: (path) -> @paths.push(path) if path?

  hasPath: (path) -> path in (@paths ? [])

  loadPaths: (noKnownPaths=false) ->
    PathsLoader ?= require './paths-loader'

    new Promise (resolve, reject) =>
      rootPaths = @getRootPaths()
      knownPaths = if noKnownPaths then [] else @paths ? []
      config = {
        knownPaths
        @timestamp
        ignoredNames: @getIgnoredNames()
        paths: rootPaths
        traverseIntoSymlinkDirectories: atom.config.get 'pigments.traverseIntoSymlinkDirectories'
        sourceNames: @getSourceNames()
        ignoreVcsIgnores: atom.config.get('pigments.ignoreVcsIgnoredPaths')
      }
      PathsLoader.startTask config, (results) =>
        for p in knownPaths
          isDescendentOfRootPaths = rootPaths.some (root) ->
            p.indexOf(root) is 0

          unless isDescendentOfRootPaths
            results.removed ?= []
            results.removed.push(p)

        resolve(results)

  updatePaths: ->
    return Promise.resolve() unless @initialized

    @loadPaths().then ({dirtied, removed}) =>
      @deleteVariablesForPaths(removed)

      @paths = @paths.filter (p) -> p not in removed
      @paths.push(p) for p in dirtied when p not in @paths

      @emitter.emit 'did-change-paths', @getPaths()
      @reloadVariablesForPaths(dirtied)

  isVariablesSourcePath: (path) ->
    return false unless path

    minimatch ?= require 'minimatch'
    path = atom.project.relativize(path)
    sources = @getSourceNames()

    return true for source in sources when minimatch(path, source, matchBase: true, dot: true)

  isIgnoredPath: (path) ->
    return false unless path

    minimatch ?= require 'minimatch'
    path = atom.project.relativize(path)
    ignoredNames = @getIgnoredNames()

    return true for ignore in ignoredNames when minimatch(path, ignore, matchBase: true, dot: true)

  scopeFromFileName: (path) ->
    scopeFromFileName ?= require './scope-from-file-name'

    scope = scopeFromFileName(path)

    if scope is 'sass' or scope is 'scss'
      scope = [scope, @getSassScopeSuffix()].join(':')

    scope

  ##    ##     ##    ###    ########   ######
  ##    ##     ##   ## ##   ##     ## ##    ##
  ##    ##     ##  ##   ##  ##     ## ##
  ##    ##     ## ##     ## ########   ######
  ##     ##   ##  ######### ##   ##         ##
  ##      ## ##   ##     ## ##    ##  ##    ##
  ##       ###    ##     ## ##     ##  ######

  getPalette: ->
    Palette ?= require './palette'

    return new Palette unless @isInitialized()
    new Palette(@getColorVariables())

  getContext: -> @variables.getContext()

  getVariables: -> @variables.getVariables()

  getVariableExpressionsRegistry: -> @variableExpressionsRegistry

  getVariableById: (id) -> @variables.getVariableById(id)

  getVariableByName: (name) -> @variables.getVariableByName(name)

  getColorVariables: -> @variables.getColorVariables()

  getColorExpressionsRegistry: -> @colorExpressionsRegistry

  showVariableInFile: (variable) ->
    atom.workspace.open(variable.path).then (editor) ->
      {Emitter, CompositeDisposable, Range} = require 'atom' unless Range?

      buffer = editor.getBuffer()

      bufferRange = Range.fromObject [
        buffer.positionForCharacterIndex(variable.range[0])
        buffer.positionForCharacterIndex(variable.range[1])
      ]

      editor.setSelectedBufferRange(bufferRange, autoscroll: true)

  emitVariablesChangeEvent: (results) ->
    @emitter.emit 'did-update-variables', results

  loadVariablesForPath: (path) -> @loadVariablesForPaths [path]

  loadVariablesForPaths: (paths) ->
    new Promise (resolve, reject) =>
      @scanPathsForVariables paths, (results) => resolve(results)

  getVariablesForPath: (path) -> @variables.getVariablesForPath(path)

  getVariablesForPaths: (paths) -> @variables.getVariablesForPaths(paths)

  deleteVariablesForPath: (path) -> @deleteVariablesForPaths [path]

  deleteVariablesForPaths: (paths) ->
    @variables.deleteVariablesForPaths(paths)

  reloadVariablesForPath: (path) -> @reloadVariablesForPaths [path]

  reloadVariablesForPaths: (paths) ->
    promise = Promise.resolve()
    promise = @initialize() unless @isInitialized()

    promise
    .then =>
      if paths.some((path) => path not in @paths)
        return Promise.resolve([])

      @loadVariablesForPaths(paths)
    .then (results) =>
      @variables.updateCollection(results, paths)

  scanPathsForVariables: (paths, callback) ->
    if paths.length is 1 and colorBuffer = @colorBufferForPath(paths[0])
      colorBuffer.scanBufferForVariables().then (results) -> callback(results)
    else
      PathsScanner ?= require './paths-scanner'

      PathsScanner.startTask paths.map((p) => [p, @scopeFromFileName(p)]), @variableExpressionsRegistry, (results) -> callback(results)

  loadThemesVariables: ->
    {THEME_VARIABLES} = require './uris' unless THEME_VARIABLES?
    ATOM_VARIABLES ?= require './atom-variables'

    iterator = 0
    variables = []
    html = ''
    ATOM_VARIABLES.forEach (v) -> html += "<div class='#{v}'>#{v}</div>"

    div = document.createElement('div')
    div.className = 'pigments-sampler'
    div.innerHTML = html
    document.body.appendChild(div)

    ATOM_VARIABLES.forEach (v,i) ->
      node = div.children[i]
      color = getComputedStyle(node).color
      end = iterator + v.length + color.length + 4

      variable =
        name: "@#{v}"
        line: i
        value: color
        range: [iterator,end]
        path: THEME_VARIABLES

      iterator = end
      variables.push(variable)

    document.body.removeChild(div)
    return variables

  ##     ######  ######## ######## ######## #### ##    ##  ######    ######
  ##    ##    ## ##          ##       ##     ##  ###   ## ##    ##  ##    ##
  ##    ##       ##          ##       ##     ##  ####  ## ##        ##
  ##     ######  ######      ##       ##     ##  ## ## ## ##   ####  ######
  ##          ## ##          ##       ##     ##  ##  #### ##    ##        ##
  ##    ##    ## ##          ##       ##     ##  ##   ### ##    ##  ##    ##
  ##     ######  ########    ##       ##    #### ##    ##  ######    ######

  getRootPaths: -> atom.project.getPaths()

  getSassScopeSuffix: ->
    @sassShadeAndTintImplementation ? atom.config.get('pigments.sassShadeAndTintImplementation') ? 'compass'

  setSassShadeAndTintImplementation: (@sassShadeAndTintImplementation) ->
    @colorExpressionsRegistry.emitter.emit 'did-update-expressions', {
      registry: @colorExpressionsRegistry
    }

  getSourceNames: ->
    names = ['.pigments']
    names = names.concat(@sourceNames ? [])
    unless @ignoreGlobalSourceNames
      names = names.concat(atom.config.get('pigments.sourceNames') ? [])
    names

  setSourceNames: (@sourceNames=[]) ->
    return if not @initialized? and not @initializePromise?

    @initialize().then => @loadPathsAndVariables(true)

  setIgnoreGlobalSourceNames: (@ignoreGlobalSourceNames) ->
    @updatePaths()

  getSearchNames: ->
    names = []
    names = names.concat(@sourceNames ? [])
    names = names.concat(@searchNames ? [])
    unless @ignoreGlobalSearchNames
      names = names.concat(atom.config.get('pigments.sourceNames') ? [])
      names = names.concat(atom.config.get('pigments.extendedSearchNames') ? [])
    names

  setSearchNames: (@searchNames=[]) ->

  setIgnoreGlobalSearchNames: (@ignoreGlobalSearchNames) ->

  getIgnoredNames: ->
    names = @ignoredNames ? []
    unless @ignoreGlobalIgnoredNames
      names = names.concat(@getGlobalIgnoredNames() ? [])
      names = names.concat(atom.config.get('core.ignoredNames') ? [])
    names

  getGlobalIgnoredNames: ->
    atom.config.get('pigments.ignoredNames')?.map (p) ->
      if /\/\*$/.test(p) then p + '*' else p

  setIgnoredNames: (@ignoredNames=[]) ->
    if not @initialized? and not @initializePromise?
      return Promise.reject('Project is not initialized yet')

    @initialize().then =>
      dirtied = @paths.filter (p) => @isIgnoredPath(p)
      @deleteVariablesForPaths(dirtied)

      @paths = @paths.filter (p) => !@isIgnoredPath(p)
      @loadPathsAndVariables(true)

  setIgnoreGlobalIgnoredNames: (@ignoreGlobalIgnoredNames) ->
    @updatePaths()

  getIgnoredScopes: ->
    scopes = @ignoredScopes ? []
    unless @ignoreGlobalIgnoredScopes
      scopes = scopes.concat(atom.config.get('pigments.ignoredScopes') ? [])

    scopes = scopes.concat(@ignoredFiletypes)
    scopes

  setIgnoredScopes: (@ignoredScopes=[]) ->
    @emitter.emit('did-change-ignored-scopes', @getIgnoredScopes())

  setIgnoreGlobalIgnoredScopes: (@ignoreGlobalIgnoredScopes) ->
    @emitter.emit('did-change-ignored-scopes', @getIgnoredScopes())

  setSupportedFiletypes: (@supportedFiletypes=[]) ->
    @updateIgnoredFiletypes()
    @emitter.emit('did-change-ignored-scopes', @getIgnoredScopes())

  updateIgnoredFiletypes: ->
    @ignoredFiletypes = @getIgnoredFiletypes()

  getIgnoredFiletypes: ->
    filetypes = @supportedFiletypes ? []

    unless @ignoreGlobalSupportedFiletypes
      filetypes = filetypes.concat(atom.config.get('pigments.supportedFiletypes') ? [])

    filetypes = ['*'] if filetypes.length is 0

    return [] if filetypes.some (type) -> type is '*'

    scopes = filetypes.map (ext) ->
      atom.grammars.selectGrammar("file.#{ext}")?.scopeName.replace(/\./g, '\\.')
    .filter (scope) -> scope?

    ["^(?!\\.(#{scopes.join('|')}))"]

  setIgnoreGlobalSupportedFiletypes: (@ignoreGlobalSupportedFiletypes) ->
    @updateIgnoredFiletypes()
    @emitter.emit('did-change-ignored-scopes', @getIgnoredScopes())

  themesIncluded: -> @includeThemes

  setIncludeThemes: (includeThemes) ->
    return Promise.resolve() if includeThemes is @includeThemes

    @includeThemes = includeThemes
    if @includeThemes
      @includeThemesVariables()
    else
      @disposeThemesVariables()

  includeThemesVariables: ->
    @themesSubscription = atom.themes.onDidChangeActiveThemes =>
      return unless @includeThemes

      {THEME_VARIABLES} = require './uris' unless THEME_VARIABLES?

      variables = @loadThemesVariables()
      @variables.updatePathCollection(THEME_VARIABLES, variables)

    @subscriptions.add @themesSubscription
    @variables.addMany(@loadThemesVariables())

  disposeThemesVariables: ->
    {THEME_VARIABLES} = require './uris' unless THEME_VARIABLES?

    @subscriptions.remove @themesSubscription
    @variables.deleteVariablesForPaths([THEME_VARIABLES])
    @themesSubscription.dispose()

  getTimestamp: -> new Date()

  serialize: ->
    unless SERIALIZE_VERSION?
      {SERIALIZE_VERSION, SERIALIZE_MARKERS_VERSION} = require './versions'

    data =
      deserializer: 'ColorProject'
      timestamp: @getTimestamp()
      version: SERIALIZE_VERSION
      markersVersion: SERIALIZE_MARKERS_VERSION
      globalSourceNames: atom.config.get('pigments.sourceNames')
      globalIgnoredNames: atom.config.get('pigments.ignoredNames')

    if @ignoreGlobalSourceNames?
      data.ignoreGlobalSourceNames = @ignoreGlobalSourceNames
    if @ignoreGlobalSearchNames?
      data.ignoreGlobalSearchNames = @ignoreGlobalSearchNames
    if @ignoreGlobalIgnoredNames?
      data.ignoreGlobalIgnoredNames = @ignoreGlobalIgnoredNames
    if @ignoreGlobalIgnoredScopes?
      data.ignoreGlobalIgnoredScopes = @ignoreGlobalIgnoredScopes
    if @includeThemes?
      data.includeThemes = @includeThemes
    if @ignoredScopes?
      data.ignoredScopes = @ignoredScopes
    if @ignoredNames?
      data.ignoredNames = @ignoredNames
    if @sourceNames?
      data.sourceNames = @sourceNames
    if @searchNames?
      data.searchNames = @searchNames

    data.buffers = @serializeBuffers()

    if @isInitialized()
      data.paths = @paths
      data.variables = @variables.serialize()

    data

  serializeBuffers: ->
    out = {}
    for id,colorBuffer of @colorBuffersByEditorId
      out[id] = colorBuffer.serialize()
    out
