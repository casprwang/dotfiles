os = require 'os'

# Public: GrammarUtils.OperatingSystem - a module which exposes different
# platform related helper functions.
module.exports =
  isDarwin: ->
    @platform() is 'darwin'

  isWindows: ->
    @platform() is 'win32'

  isLinux: ->
    @platform() is 'linux'

  platform: ->
    os.platform()

  release: ->
    os.release()
