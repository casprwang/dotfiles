linter = require "./linter"
{CompositeDisposable} = require 'atom'

disposables = new CompositeDisposable

module.exports =
  config:
    jslintVersion:
      title: "JSLint version:"
      description: "Atom needs a reload for this setting to take effect"
      type: "string"
      default: "latest"
      enum: ["latest", "es6", "2015-05-08", "2014-07-08", "2014-04-21", "2014-02-06", "2014-01-26", "2013-11-23", "2013-09-22", "2013-08-26", "2013-08-13", "2013-02-03"]
    validateOnSave:
      title: "Validate on save"
      type: "boolean"
      default: true
    validateOnChange:
      title: "Validate while typing"
      type: "boolean"
      default: false
    hideOnNoErrors:
      title: "Hide panel if no errors was found"
      type: "boolean"
      default: false
    useFoldModeAsDefault:
      title: "Use fold mode as default"
      type: "boolean"
      default: false

  activate: ->
    editor = atom.workspace.getActiveTextEditor()
    subscriptions =
      onSave: null
      onChange: null

    atom.commands.add "atom-workspace", "jslint:lint", linter

    disposables.add atom.workspace.observeTextEditors (editor) ->
      buff = editor.getBuffer()
      disposables.add buff.onDidSave ->
        linter() if atom.config.get("jslint.validateOnSave") is true
      disposables.add buff.onDidStopChanging ->
        linter() if atom.config.get("jslint.validateOnChange") is true

  deactivate: ->
    disposables.dispose()
