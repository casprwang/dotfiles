[loophole, pug] = []

module.exports =
class PugProvider
  fromScopeName: 'source.pug'
  toScopeName: 'text.html.basic'

  transform: (code, {filePath} = {}) ->
    pug ?= @unsafe -> require 'pug'

    options =
      pretty: true
      filename: filePath

    {
      code: @unsafe -> pug.render(code, options)
      sourceMap: null
    }

  unsafe: (fn) ->
    loophole ?= require 'loophole'
    {allowUnsafeEval, allowUnsafeNewFunction} = loophole
    allowUnsafeNewFunction -> allowUnsafeEval -> fn()
