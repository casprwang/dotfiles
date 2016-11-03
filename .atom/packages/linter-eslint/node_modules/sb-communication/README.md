SB-Communication
================

SB-Communication is a base communication low-level library meant to be used in other communication libraries.
It allows promise-based communication on both ends, You must write a wrapper for it for your use-case specific
stream, socket or resource though. It works in both browsers and node!

#### Example Communication Implementation

```js
'use babel'

import Communication from 'sb-communication'

const worker = new WebWorker('worker.js')
const wrapper = new Communication()

worker.onmessage = function(message) {
  wrapper.parseMessage(message.data)
}
wrapper.onShouldSend(function(data) {
  worker.postMessage(data)
})

// Event-Specific bindings
wrapper.onRequest('count-pi', function(data, message) {
  console.log(data)
  message.response = new Promise(function(resolve, reject) {
    message.response = "Something else"
    resolve()
  })
})
```

#### API

```js
export default class Communication {
  constructor(debug: Boolean)
  parseMessage(message: String | Object)
  request(type: String, data: Mixed)
  onRequest(type: String, callback: Function)
  onShouldSend(callback: Function)
  dispose()
}
```

#### Message
This is the shape of the message object you get on request handlers

```js
const message<T> = {
  id: String,
  name: String,
  type: 'request',
  data: T,
  response: ?mixed
}
```

#### LICENSE

This project is licensed under the terms of MIT License.
