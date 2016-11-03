[loophole, jade] = []

module.exports =
class JadeProvider
  fromScopeName: 'source.jade'
  toScopeName: 'text.html.basic'

  transform: (code, {filePath} = {}) ->
    jade ?= @unsafe -> require 'jade'

    options =
      pretty: true
      filename: filePath

    {
      code: @unsafe -> jade.render(code, options)
      sourceMap: null
    }

  unsafe: (fn) ->
    loophole ?= require 'loophole'
    {allowUnsafeEval, allowUnsafeNewFunction} = loophole
    allowUnsafeNewFunction -> allowUnsafeEval -> fn()
