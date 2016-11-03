'use strict';

function promisify (fn, options) {
  if (typeof fn !== 'function') {
    throw new TypeError('first parameter is not a function');
  }

  const opts = Object.assign({
    context: {},
    multiArgs: false
  }, options);

  return function () {
    const callArgs = Array.prototype.slice.call(arguments);

    return new Promise(function (resolve, reject) {
      callArgs.push(function (err) {
        if (err) {
          reject(err);
          return;
        }

        if (opts.multiArgs) {
          resolve(Array.prototype.slice.call(arguments, 1));
        } else {
          resolve(arguments[1]);
        }
      });

      fn.apply(opts.context, callArgs);
    });
  };
}

module.exports = promisify;
