electron-proxy-agent
===============
### A proxy `http.Agent` implementation for HTTP and HTTPS,
rewritten to work seamlessly with [Electron](https://github.com/atom/electron) API

This module provides an `http.Agent` implementation that uses the [session.resolveProxy](https://github.com/atom/electron/blob/master/docs/api/session.md#sesresolveproxyurl-callback) API of [Electron](https://github.com/atom/electron) to resolve which HTTP, HTTPS, or SOCKS proxy, or if a direct connection should be used to connect to the HTTP(S) endpoint.

It is designed to be be used with the built-in `http` and `https` modules


Installation
------------

Install with `npm`:

``` bash
$ npm install electron-proxy-agent --save
```


Examples
-------

- Single request
``` js
var url = require('url');
var http = require('http');
var ElectronProxyAgent = require('electron-proxy-agent');
var session = require('session').defaultSession;

// HTTP endpoint for the proxy to connect to
var endpoint = 'http://nodejs.org/api/';
console.log('attempting to GET %j', endpoint);
var opts = url.parse(endpoint);

// create an instance of the `ElectronProxyAgent` class with the default electron session
var agent = new ElectronProxyAgent(session);
opts.agent = agent;

http.get(opts, function (res) {
  console.log('"response" event!', res.headers);
  res.pipe(process.stdout);
});
```

- Global agent
``` js
var http = require('http');
var https = require('http');
var ElectronProxyAgent = require('electron-proxy-agent');
var session = require('session').defaultSession;

// use ElectronProxyAgent as http and https globalAgents
http.globalAgent = https.globalAgent = new ElectronProxyAgent(session);
```

Notes
-----
- Passing no or invalid parameter to the constructor would result in trying to use default session.
```
new ElectronProxyAgent() // try to use default session
```
- Could be used or mocked out of Electron by passing an object that implements resolveProxy
```
new ElectronProxyAgent({
  resolveProxy : function(url, callback) {
    callback("PROXY 127.0.0.1:8888; DIRECT"); // return a valid pac syntax
  }
})
```


License
-------

(The MIT License)

Copyright (c) 2014 Nathan Rajlich &lt;nathan@tootallnate.net&gt;
Copyright (c) 2015 Félicien François &lt;felicien@tweakstyle.com&gt;

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

