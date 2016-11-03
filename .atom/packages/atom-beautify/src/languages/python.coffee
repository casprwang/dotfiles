# Get Atom defaults
scope = ['source.python']
tabLength = atom?.config.get('editor.tabLength', scope: scope) ? 4
softTabs = atom?.config.get('editor.softTabs', scope: scope) ? true
defaultIndentSize = (if softTabs then tabLength else 1)
defaultIndentChar = (if softTabs then " " else "\t")
defaultIndentWithTabs = not softTabs

module.exports = {

  name: "Python"
  namespace: "python"

  ###
  Supported Grammars
  ###
  grammars: [
    "Python"
  ]

  ###
  Supported extensions
  ###
  extensions: [
    "py"
  ]

  options:
    max_line_length:
      type: 'integer'
      default: 79
      description: "set maximum allowed line length"
    indent_size:
      type: 'integer'
      default: defaultIndentSize
      minimum: 0
      description: "Indentation size/length"
    ignore:
      type: 'array'
      default: ["E24"]
      items:
        type: 'string'
      description: "do not fix these errors/warnings"
    sort_imports:
      type: 'boolean'
      default: false
      description: "sort imports (requires isort installed)"

}
