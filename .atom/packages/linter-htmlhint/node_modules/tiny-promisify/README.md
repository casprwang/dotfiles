# Tiny Node Promisify

Minimalist library to promisify functions expecting node-style callbacks.

## Install

```bash
npm install tiny-promisify
```

## Usage

Given a `fn` that uses the node-style callbacks, expecting a callback as the last parameter and this callback expecting an `err` as the first parameter, you can obtain a new function that return promises as follows:

```javascript
var promisify = require('tiny-promisify');

function fn (args, callback) {
  // fn code here...
  callback(err, results);
}

var fnAsync = primisify(fn);
fnAsync(args).then(function (result) {
  // your code here...
}).catch(function (err) {
  // handle error here...
});
```

## API

### `promisify(fn, [options])`

* `fn` is a function that receives a callback as the last. argument. The callback will receive an `err` object as the first argument.
* `options` is an optional object having the following properties:
  * `multiArgs` set to `true` will make the promise resolve to an array containing all the parameters passed to the callback. Otherwise, only the first non-error parameter is passed to the promise success callback. Defaults to `false`.
  * `context` is the object uses as `this` when calling `fn`. Defaults to `{}`.

Returns a new function that wraps `fn` in a promise.

## Notes

The module uses native implementations of `Promise` and `Object.assign()`, `node` version 4.0 or higher is required.
