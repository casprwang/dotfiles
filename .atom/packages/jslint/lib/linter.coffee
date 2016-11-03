{MessagePanelView, PlainMessageView, LineMessageView} = require "atom-message-panel"
config = require("./config")
jsLint = require("jslint").load atom.config.get("jslint.jslintVersion")
jsLinter = require("jslint").linter.doLint
messages = new MessagePanelView
  title: "<span class=\"icon-bug\"></span> JSLint report"
  rawTitle: true
  closeMethod: "destroy"
editor = null
content = null
result = null

module.exports = ->
  editor = atom.workspace.getActiveTextEditor()

  return unless editor
  return unless editor.getGrammar().name is "JavaScript"

  content = editor.getText()
  result = jsLinter jsLint, content, config()

  messages.clear()
  messages.attach()

  if atom.config.get("jslint.useFoldModeAsDefault") and messages.summary.css("display") is "none"
    messages.toggle()

  if result.errors.length is 0
    atom.config.observe "jslint.hideOnNoErrors", (value) ->
      if value is true
        messages.close()
      else
        messages.add new PlainMessageView
          message: "No errors were found!"
          className: "text-success"
  else
    for error in result.errors
      continue if !error

      if atom.config.get("jslint.jslintVersion") is "es6"
        messages.add new LineMessageView
          message: error.message
          line: error.line + 1
          character: error.column + 1
          preview: error.a.trim() if error.a
          className: "text-error"
      else
        messages.add new LineMessageView
          message: error.reason
          line: error.line
          character: error.character
          preview: error.evidence.trim() if error.evidence
          className: "text-error"

  atom.workspace.onDidChangeActivePaneItem ->
    messages.close()
