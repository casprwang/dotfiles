var re = /\$(([a-zA-Z_]+[a-zA-Z0-9_]*)|\{([a-zA-Z_]+[a-zA-Z0-9_]*)\})/g

function resolveEnv (input) {
  return input.replace(re, function ($0, $1, $2, $3) {
    var key = $2 || $3

    if (process.env.hasOwnProperty(key)) {
      return process.env[key]
    }

    return ''
  })
}

module.exports = resolveEnv
