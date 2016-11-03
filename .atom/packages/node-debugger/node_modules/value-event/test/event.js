var EventSinks = require('event-sinks/geval')
var document = require('global/document')
var test = require('tape')
var setImmediate = require('timers').setImmediate

var Event = require('./lib/create-event.js')
var h = require('./lib/h.js')
var event = require('../event.js')

test('event is a function', function (assert) {
    assert.equal(typeof event, 'function')
    assert.end()
})

test('can add event', function (assert) {
    var elem = h('div')
    document.body.appendChild(elem)
    var input = EventSinks('', [
        'someEvent'
    ])

    var values = []
    input.events.someEvent(function (data) {
        values.push(data)
    })
    elem.addEventListener('click', event(input.sinks.someEvent, {
        some: 'data'
    }))

    var ev = Event('click')
    elem.dispatchEvent(ev)

    setImmediate(function () {
        assert.equal(values.length, 1)
        assert.equal(values[0].some, 'data')

        document.body.removeChild(elem)
        assert.end()
    })
})

test('can add (function) event', function (assert) {
    var elem = h('div')
    document.body.appendChild(elem)

    var values = []
    var sink = function (data) {
        values.push(data)
    }
    elem.addEventListener('click', event(sink, {
        some: 'data'
    }))

    var ev = Event('click')
    elem.dispatchEvent(ev)

    setImmediate(function () {
        assert.equal(values.length, 1)
        assert.equal(values[0].some, 'data')

        document.body.removeChild(elem)
        assert.end()
    })
})
