var test  = require('tape')
var Observ = require("observ")
var computed = require("observ/computed")
var ObservStruct   = require('observ-struct')
var ObservVarHash = require("observ-varhash")
var ObservArray = require("../index")

test("ObservArray.sort() should work", function (assert) {
    var arr = ObservArray([
        Observ(3),
        Observ(2),
        Observ(1),
        Observ(0)
    ])

    var changes = []

    arr(function(state) {
        changes.push(state)
    })

    arr.sort()

    assert.equal(changes.length, 1)
    assert.deepEqual(changes[0].slice(), [ 0, 1, 2, 3 ])
    assert.deepEqual(changes[0]._diff, [ [ 0, 4, 0, 1, 2, 3 ] ])

    assert.end()
})

test("ObservArray.sort(cmp_fn) should work", function (assert) {
    var arr = ObservArray([
        Observ(0),
        Observ(1),
        Observ(2),
        Observ(3)
    ])

    var changes = []

    arr(function(state) {
        changes.push(state)
    })

    arr.sort(function(a, b) {
        return a < b
    })

    assert.equal(changes.length, 1)
    assert.deepEqual(changes[0].slice(), [ 3, 2, 1, 0 ])
    assert.deepEqual(changes[0]._diff, [ [ 0, 4, 3, 2, 1, 0 ] ])

    assert.end()
})

test("ObservArray.sort raw values", function (assert) {
    var arr = ObservArray([
        0, 1, 2, 3
    ])

    var changes = []

    arr(function(state) {
        changes.push(state)
    })

    arr.sort(function(a, b) {
        return a < b
    })

    assert.equal(changes.length, 1)
    assert.deepEqual(changes[0].slice(), [ 3, 2, 1, 0 ])
    assert.deepEqual(changes[0]._diff, [ [ 0, 4, 3, 2, 1, 0 ] ])

    assert.end()
})

test("can sort by struct key", function(assert) {
    var arr = ObservArray([
        ObservStruct({ foo: "a" }),
        ObservStruct({ foo: "b" }),
        ObservStruct({ foo: "c" })
    ])

    var changes = []

    arr(function(state) {
        changes.push(state)
    })

    arr.sort(function(a, b) {
        return a.foo < b.foo
    })

    assert.equal(changes.length, 1)

    assert.deepEqual(changes[0].slice(), [
        { foo: "c" },
        { foo: "b" },
        { foo: "a" }
    ])

    assert.deepEqual(changes[0]._diff, [
        [ 0, 3,
        { foo: "c" },
        { foo: "b" },
        { foo: "a" }
        ]
    ])

    assert.end()
})

test("ObservArray sort should preserve Observ", function(assert) {
    var obsA = Observ("A")
    var obsB = Observ("B")
    var obsC = Observ("C")

    var arr = ObservArray([
        obsA, obsB, obsC
    ])

    var changes = []

    arr(function(state) {
        changes.push(state)
    })

    arr.sort(function(a, b) {
        return a < b
    })

    obsA.set("A2")

    assert.equal(changes.length, 2)

    assert.deepEqual(changes[0].slice(), [
        "C", "B", "A"
    ])

    assert.deepEqual(changes[0]._diff, [
       [ 0, 3, "C", "B", "A" ]
    ])

    assert.deepEqual(changes[1].slice(), [
        "C", "B", "A2"
    ])

    assert.deepEqual(changes[1]._diff, [
       [ 2, 1, "A2" ]
    ])

    assert.end()
})

test("ObservArray sort should preserve vvarhaslt harhash objects", function(assert) {
    var vhA = ObservVarHash({})
    var vhB = ObservVarHash({})
    var vhC = ObservVarHash({})

    var arr = ObservArray([
        vhA, vhB, vhC
    ])

    var changes = []

    arr(function(state) {
        changes.push(state)
    })

    vhA.put("foo", "A")
    vhB.put("foo", "B")
    vhC.put("foo", "C")

    arr.sort(function(a, b) {
        return a.foo < b.foo
    })

    arr.get(0).put("foo", "C2")

    vhA.delete("foo")

    assert.equal(changes.length, 6)

    assert.deepEqual(changes[0].slice(), [
        { foo: "A" }, {}, {}
    ])
    assert.deepEqual(changes[0]._diff, [
        [0, 1, { foo: "A" }]
    ])
    assert.deepEqual(changes[1].slice(), [
        { foo: "A" }, { foo: "B" }, { }
    ])
    assert.deepEqual(changes[1]._diff, [
        [1, 1, { foo: "B" }]
    ])
    assert.deepEqual(changes[2].slice(), [
        { foo: "A" }, { foo: "B" }, { foo: "C" }
    ])
    assert.deepEqual(changes[2]._diff, [
        [2, 1, { foo: "C" }]
    ])

    assert.deepEqual(changes[3].slice(), [
        { foo: "C" }, { foo: "B" }, { foo: "A" }
    ])
    assert.deepEqual(changes[3]._diff, [
        [0, 3, { foo: "C" }, { foo: "B" }, { foo: "A" }]
    ])

    assert.deepEqual(changes[4].slice(), [
        { foo: "C2" }, { foo: "B" }, { foo: "A" }
    ])

    assert.deepEqual(changes[4]._diff, [
        [ 0, 1, { foo: "C2" } ]
    ])

    assert.deepEqual(changes[5].slice(), [
        { foo: "C2" }, { foo: "B" }, { }
    ])

    assert.deepEqual(changes[5]._diff, [
        [ 2, 1, {} ]
    ])
    assert.end()
})

test("batch changes with transactions on sorted array", function (assert) {
    var items = {
        foo: Observ("foo"),
        bar: Observ("bar"),
        foobar: Observ("foobar"),
        baz: Observ("baz"),
        bazbar: Observ("bazbar"),
        foobaz: Observ("foobaz"),
        foobarbaz: Observ("foobarbaz")
    }

    var arr = ObservArray([ items.foo, items.bar ])
    var changes = []

    arr(function (state) {
        changes.push(state)
    })

    arr.sort()

    arr.transaction(function(rawList){
        rawList.push(items.foobar)
        rawList.splice(1, 1, items.baz, items.bazbar)
        rawList.unshift(items.foobaz)
        rawList[6] = items.foobarbaz
    })

    arr.sort()

    assert.equal(changes.length, 3)

    assert.deepEqual(changes[0].slice(), [
        "bar", "foo"
    ])

    assert.deepEqual(changes[0]._diff, [
        [ 0, 2, "bar", "foo" ]
    ])

    assert.deepEqual(changes[1].slice(), [
        "foobaz", "bar", "baz", "bazbar", "foobar", undefined, "foobarbaz"
    ])

    assert.deepEqual(changes[1]._diff, [
        [1,1,"baz","bazbar","foobar", undefined, "foobarbaz"],
        [0,0,"foobaz"]
    ])

    assert.deepEqual(changes[2].slice(), [
        "bar", "baz", "bazbar", "foobar", "foobarbaz", "foobaz", undefined
    ])
    assert.deepEqual(changes[2]._diff, [
        [ 0, 7, "bar", "baz", "bazbar", "foobar", "foobarbaz", "foobaz", undefined ]
    ])

    // check internal list
    assert.equal(arr._list.length, changes[2].length)

    changes[2].forEach(function(val, i){
        assert.equal(arr._list[i], items[val])
    })

    assert.end()
})

test("can call array methods on sorted ObservArray", function (assert) {
    var arr = ObservArray([
        Observ(0),
        Observ(1),
        Observ(2),
        Observ(3),
        Observ(5)
    ])

    arr.sort(function(a, b) {
        return a < b
    })

    var doubles = arr.map(function (o) {
        return computed([o], function (o) { return o * 2 })
    })

    var changes = []

    doubles(function (state) {
        changes.push(state)
    })

    assert.equal(typeof doubles.get, "function")
    assert.equal(typeof doubles.getLength, "function")
    assert.equal(Array.isArray(doubles), false)

    arr.get(2).set(5)

    assert.equal(changes.length, 1)
    assert.deepEqual(changes[0].slice(), [
        10, 6, 10, 2, 0
    ])

    doubles.push(Observ(8))

    assert.equal(changes.length, 2)
    assert.deepEqual(changes[1].slice(), [
        10, 6, 10, 2, 0, 8
    ])

    assert.end()
})

test("sort should maintain observ objects of the same value", function(assert) {
    var a1 = Observ("A")
    var a2 = Observ("A")
    var b1 = Observ("B")

    var arr = ObservArray([ a1, b1, a2 ])

    var changes = []

    arr(function(state) {
        changes.push(state)
    })

    arr.sort()

    a1.set("A1")
    a2.set("A2")

    assert.equal(changes.length, 3)

    assert.deepEqual(changes[0].slice(), [ "A", "A", "B" ])
    assert.deepEqual(changes[0]._diff, [
         [ 0, 3, "A", "A", "B" ]
    ])

    assert.deepEqual(changes[1].slice(), [ "A1", "A", "B" ])
    assert.deepEqual(changes[1]._diff, [
        [ 0, 1, "A1" ]
    ])

    assert.deepEqual(changes[2].slice(), [ "A1", "A2", "B" ])
    assert.deepEqual(changes[2]._diff, [
         [ 1, 1, "A2" ]
    ])

    assert.end()
})
