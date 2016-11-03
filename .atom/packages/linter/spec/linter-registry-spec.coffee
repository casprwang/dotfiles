describe 'linter-registry', ->
  LinterRegistry = require('../lib/linter-registry')
  EditorLinter = require('../lib/editor-linter')
  linterRegistry = null
  {getLinter, getMessage} = require('./common')

  beforeEach ->
    waitsForPromise ->
      atom.workspace.destroyActivePaneItem()
      atom.workspace.open('file.txt')
    linterRegistry?.dispose()
    linterRegistry = new LinterRegistry

  describe '::addLinter', ->
    it 'adds error notification if linter is invalid', ->
      linterRegistry.addLinter({})
      expect(atom.notifications.getNotifications().length).toBe(1)
    it 'pushes linter into registry when valid', ->
      linter = getLinter()
      linterRegistry.addLinter(linter)
      expect(linterRegistry.linters.size).toBe(1)
    it 'set deactivated to false on linter', ->
      linter = getLinter()
      linterRegistry.addLinter(linter)
      expect(linter.deactivated).toBe(false)

  describe '::hasLinter', ->
    it 'returns true if present', ->
      linter = getLinter()
      linterRegistry.addLinter(linter)
      expect(linterRegistry.hasLinter(linter)).toBe(true)
    it 'returns false if not', ->
      linter = getLinter()
      expect(linterRegistry.hasLinter(linter)).toBe(false)

  describe '::deleteLinter', ->
    it 'deletes the linter from registry', ->
      linter = getLinter()
      linterRegistry.addLinter(linter)
      expect(linterRegistry.hasLinter(linter)).toBe(true)
      linterRegistry.deleteLinter(linter)
      expect(linterRegistry.hasLinter(linter)).toBe(false)
    it 'sets deactivated to true on linter', ->
      linter = getLinter()
      linterRegistry.addLinter(linter)
      linterRegistry.deleteLinter(linter)
      expect(linter.deactivated).toBe(true)

  describe '::lint', ->
    it "doesn't lint if textEditor isn't active one", ->
      editorLinter = new EditorLinter(atom.workspace.getActiveTextEditor())
      linter = {
        grammarScopes: ['*']
        lintOnFly: false
        modifiesBuffer: false
        scope: 'file'
        lint: ->
      }
      linterRegistry.addLinter(linter)
      waitsForPromise ->
        atom.workspace.open('test2.txt').then ->
          expect(linterRegistry.lint({onChange: false, editorLinter})).toBeUndefined()
    it "doesn't lint if textEditor doesn't have a path", ->
      editorLinter = new EditorLinter(atom.workspace.getActiveTextEditor())
      linter = {
        grammarScopes: ['*']
        lintOnFly: false
        scope: 'file'
        lint: ->
      }
      linterRegistry.addLinter(linter)
      waitsForPromise ->
        atom.workspace.open('someNonExistingFile.txt').then ->
          expect(linterRegistry.lint({onChange: false, editorLinter})).toBeUndefined()
    it 'disallows two co-current lints of same type', ->
      editorLinter = new EditorLinter(atom.workspace.getActiveTextEditor())
      linter = {
        grammarScopes: ['*']
        lintOnFly: false
        scope: 'file'
        lint: ->
      }
      linterRegistry.addLinter(linter)
      expect(linterRegistry.lint({onChange: false, editorLinter})).toBeDefined()
      expect(linterRegistry.lint({onChange: false, editorLinter})).toBeUndefined()

  describe '::onDidUpdateMessages', ->
    it 'is triggered whenever messages change', ->
      editorLinter = new EditorLinter(atom.workspace.getActiveTextEditor())
      linter = {
        grammarScopes: ['*']
        lintOnFly: false
        scope: 'file'
        lint: -> return [{type: 'Error', text: 'Something'}]
      }
      info = undefined
      linterRegistry.addLinter(linter)
      linterRegistry.onDidUpdateMessages (linterInfo) ->
        info = linterInfo
      waitsForPromise ->
        linterRegistry.lint({onChange: false, editorLinter}).then ->
          expect(info).toBeDefined()
          expect(info.messages.length).toBe(1)
