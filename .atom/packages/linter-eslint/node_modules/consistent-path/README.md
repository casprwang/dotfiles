Consistent-PATH
===================

`consistent-path` is an npm module that makes sure that you get the correct `$PATH` value even on GUI apps on OSX. It does not modify the globals and caches the result to avoid unnecessary work.

#### API

```js
module.exports = function(): string
module.exports.async = function(): Promise<string>
```

#### Example Usage

```js
import {spawnSync} from 'child_process'
import getPath from 'consistent-path'

const assign = Object.assign || require('some-object-assign-polyfill')

const env = assign({}, process.env, {PATH: getPath()})
console.log('$PATH', spawnSync('printenv', {env}))
```

#### Differences to other packages

Differences to [atom-community/environment](https://github.com/atom-community/environment):

 - See [atom-linter#62](https://github.com/AtomLinter/atom-linter/issues/62)

Differences to [sindresorhus/fix-path](https://github.com/sindresorhus/fix-path)
 - `fix-path` modifies globals
 - `fix-path` has duplication of work when multiple modules use it as there's no caching in place

#### LICENSE
This project is licensed under the terms of MIT License
