'use babel'

import Communication from 'sb-communication'
import {CompositeDisposable, Emitter, Disposable} from 'sb-event-kit'

class ProcessCommunication {
  constructor(process, debug) {
    if (typeof process.send !== 'function') {
      throw new Error('Invalid process specified')
    }

    this.process = process
    this.communication = new Communication(debug)
    this.emitter = new Emitter()
    this.subscriptions = new CompositeDisposable(this.communication, this.emitter)

    this.communication.onShouldSend(data => {
      this.process.send(data)
    })

    const messageCallback = message => {
      this.communication.parseMessage(message)
    }
    this.process.addListener('message', messageCallback)
    this.subscriptions.add(new Disposable(function() {
      process.removeListener('message', messageCallback)
    }))

    const exitCallback = () => {
      this.emitter.emit('did-exit')
      this.dispose()
    }
    this.process.addListener('exit', exitCallback)
    this.subscriptions.add(new Disposable(function() {
      process.removeListener('exit', exitCallback)
    }))
  }
  request(name, data = {}) {
    return this.communication.request(name, data)
  }

  onRequest(name, callback) {
    return this.communication.onRequest(name, callback)
  }
  onDidExit(callback) {
    return this.emitter.on('did-exit', callback)
  }

  kill(sig) {
    this.emitter.emit('did-exit')
    this.dispose()
    this.process.kill(sig)
  }
  dispose() {
    this.subscriptions.dispose()
  }
}

export {ProcessCommunication as Communication}
