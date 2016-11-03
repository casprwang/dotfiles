var EventSinks = require('event-sinks/geval')
var document = require('global/document')
var test = require('tape')
var setImmediate = require('timers').setImmediate

var Event = require('./lib/create-event.js')
var h = require('./lib/h.js')
var changeEvent = require('../change.js')

test('can add change event', function (assert) {
    var elem = h('div', null, [
        h('input', {
            name: 'foo',
            value: 'bar',
            type: 'text'
        })
    ])
    document.body.appendChild(elem)
    var input = EventSinks('', [
        'someEvent'
    ])

    var values = []
    var sink = input.sinks.someEvent
    input.events.someEvent(function (data) {
        values.push(data)
    })
    elem.addEventListener('input', changeEvent(sink, {
        some: 'data'
    }))

    var ev = Event('input')
    elem.childNodes[0].dispatchEvent(ev)

    setImmediate(function () {
        assert.equal(values.length, 1)
        assert.equal(values[0].some, 'data')
        assert.equal(values[0].foo, 'bar')

        document.body.removeChild(elem)
        assert.end()
    })
})

test('can add change (function) event', function (assert) {
    var elem = h('div', null, [
        h('input', {
            name: 'foo',
            value: 'bar',
            type: 'text'
        })
    ])
    document.body.appendChild(elem)

    var values = []
    var sink = function (data) {
        values.push(data)
    }
    elem.addEventListener('input', changeEvent(sink, {
        some: 'data'
    }))

    var ev = Event('input')
    elem.childNodes[0].dispatchEvent(ev)

    setImmediate(function () {
        assert.equal(values.length, 1)
        assert.equal(values[0].some, 'data')
        assert.equal(values[0].foo, 'bar')

        document.body.removeChild(elem)
        assert.end()
    })
})

test('can add change event on a select', function (assert) {
    var elem = h('div', null, [
        h('select', {
            type: 'select-one',
            name: 'foo',
            value: 'bar'
        })
    ])
    document.body.appendChild(elem)
    var input = EventSinks('', [
        'someEvent'
    ])

    var values = []
    var sink = input.sinks.someEvent
    input.events.someEvent(function (data) {
        values.push(data)
    })
    elem.addEventListener('change', changeEvent(sink, {
        some: 'data'
    }))

    var ev = Event('change')
    elem.childNodes[0].dispatchEvent(ev)

    setImmediate(function () {
        assert.equal(values.length, 1)
        assert.equal(values[0].some, 'data')
        assert.equal(values[0].foo, 'bar')

        document.body.removeChild(elem)
        assert.end()
    })
})

test('can add change event on a textarea', function (assert) {
    var elem = h('div', null, [
        h('textarea', {
            type: 'textarea',
            name: 'foo',
            value: 'bar'
        })
    ])
    document.body.appendChild(elem)
    var input = EventSinks('', [
        'someEvent'
    ])

    var values = []
    var sink = input.sinks.someEvent
    input.events.someEvent(function (data) {
        values.push(data)
    })
    elem.addEventListener('input', changeEvent(sink, {
        some: 'data'
    }))

    var ev = Event('input')
    elem.childNodes[0].dispatchEvent(ev)

    setImmediate(function () {
        assert.equal(values.length, 1)
        assert.equal(values[0].some, 'data')
        assert.equal(values[0].foo, 'bar')

        document.body.removeChild(elem)
        assert.end()
    })
})
