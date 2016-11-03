var Delegator = require('dom-delegator')
var document = require('global/document')
var test = require('tape')
var setImmediate = require('timers').setImmediate
var DataSet = require('data-set')

var Event = require('./lib/create-event.js')
var h = require('./lib/h.js')
var event = require('../event.js')

test('can add (function) event', function (assert) {
    var elem = h('div')
    document.body.appendChild(elem)

    var values = []
    Delegator() // listen to all the things
    var fn = function (data) {
        values.push(['fn', data])
    }
    DataSet(elem).click = event(fn, {
        some: 'data'
    })

    var ev = Event('click')
    elem.dispatchEvent(ev)

    setImmediate(function () {
        assert.equal(values.length, 1)
        assert.equal(values[0][0], 'fn')
        assert.equal(values[0][1].some, 'data')

        document.body.removeChild(elem)
        assert.end()
    })
})

test('can add (handle) event', function (assert) {
    var elem = h('div')
    document.body.appendChild(elem)

    var values = []
    Delegator() // listen to all the things
    var handle = Delegator.allocateHandle(function (data) {
        values.push(['fn', data])
    })
    DataSet(elem).click = event(handle, {
        some: 'data'
    })

    var ev = Event('click')
    elem.dispatchEvent(ev)

    setImmediate(function () {
        assert.equal(values.length, 1)
        assert.equal(values[0][0], 'fn')
        assert.equal(values[0][1].some, 'data')

        document.body.removeChild(elem)
        assert.end()
    })
})
