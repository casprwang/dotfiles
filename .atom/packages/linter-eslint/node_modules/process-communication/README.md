Process-Communication
====================

Process-Communication is a lightweight module that makes inter-process communication a piece of cake! It's very easy to get started with it

#### API

```js
export class Communication {
  constructor(process: Object, debug: Boolean)
  request(type: String, data: Object): Promise
  onRequest(type: String, callback: Function)
  kill(signal) // <-- also disposes
  dispose()
}
export function create() {
  return new Communication(process)
}
export function createFromProcess(process) {
  return new Communication(process)
}
export function fork(env) {
  return new Communication(Cluster.fork(env || process.env))
}
export function forkFile(filePath, args = [], options = {}) {
  return new Communication(ChildProcess.fork(filePath, args, options))
}
```

#### Example

```js
// Main.js
import {forkFile} from 'process-communication'

const communication = forkFile('Worker.js')

communication.request('random', {max: 5}).then(function(response){
  console.log('random', response)
  communication.kill()
  // or .dispose() to dispose just listener and not kill
})

// Worker.js
import {create} from 'process-communication'

const communication = create()

communication.onRequest('random', function(data, message) {
  message.response = Math.random() * data.max
})
```

#### License

This project is licensed under the terms of MIT License. See the LICENSE file for more info.
