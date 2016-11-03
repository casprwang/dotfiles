git = require '../git'
notifier = require '../notifier'
OutputViewManager = require '../output-view-manager'

module.exports = (repo) ->
  cwd = repo.getWorkingDirectory()
  git.cmd(['stash', 'pop'], {cwd})
  .then (msg) ->
    OutputViewManager.create().addLine(msg).finish() if msg isnt ''
  .catch (msg) ->
    notifier.addInfo msg
