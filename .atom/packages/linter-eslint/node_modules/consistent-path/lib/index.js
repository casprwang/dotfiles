'use strict'

let consistentEnv

module.exports = function() {
  if (process.platform === 'win32') {
    return process.env.PATH || process.env.Path
  }
  if (!consistentEnv) {
    consistentEnv = require('consistent-env')
  }
  return consistentEnv().PATH || ''
}

module.exports.async = function() {
  if (process.platform === 'win32') {
    return Promise.resolve(process.env.PATH || process.env.Path)
  }
  if (!consistentEnv) {
    consistentEnv = require('consistent-env')
  }
  return consistentEnv.async().then(function(env) {
    return env.PATH || ''
  })
}
