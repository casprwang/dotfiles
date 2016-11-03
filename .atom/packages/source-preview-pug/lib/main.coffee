PugProvider = require './pug-provider'
JadeProvider = require './jade-provider'

module.exports =

  activate: ->
    @pugProvider = new PugProvider
    @jadeProvider = new JadeProvider

  deactivate: ->
    @pugProvider = null
    @jadeProvider = null

  provide: ->
    [@pugProvider, @jadeProvider]
