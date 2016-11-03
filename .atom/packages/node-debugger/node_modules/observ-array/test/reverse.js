var test  = require('tape')
var Observ = require("observ")
var computed = require("observ/computed")
var Struct   = require('observ-struct')
var ObservArray = require("../index")

test("ObservArray array.reverse should work", function (assert) {
  var arr = ObservArray([
    Observ(1),
    Observ(2),
    Observ(3)
  ])

  var changes = []
  var initial = arr()

  arr(function(state) {
    changes.push(state)
  })

  arr.reverse()

  var reversed = arr()

  assert.equal(changes.length, 1)
  assert.deepEqual(changes[0], [3, 2, 1])
  assert.deepEqual(changes[0]._diff, [ [0, 1, 3], [2, 1, 1] ])

  assert.end()
})

test("still emits changes after reversal", function (assert) {
  var arr = ObservArray([
    Observ("foo"),
    Observ("bar"),
    Observ("baz")
  ])

  var changes = []

  arr(function(state) {
    changes.push(state)
  })

  arr.reverse()
  arr.get(0).set("baz2")
  arr.get(1).set("bar2")

  assert.equal(changes.length, 3)
  assert.deepEqual(changes[1], [ "baz2", "bar", "foo" ])
  assert.deepEqual(changes[2], [ "baz2", "bar2", "foo" ])

  assert.end()
})

test("reverse works with nested arrays", function (assert) {
    var arr = ObservArray([
        Observ("foo"),
        ObservArray([
            Observ("bar"),
            Observ("baz")
        ])
    ])
    var initArr = arr()
    var changes = []
    var innerChanges = []

    arr(function (state) {
        changes.push(state)
    })

    arr.get(1)(function (state) {
        innerChanges.push(state)
    })

    arr.reverse()

    arr.get(0).get(0).set("bar2")
    arr.get(0).get(1).set("baz2")
    arr.get(1).set("foo2")

    assert.equal(changes.length, 4)
    assert.equal(innerChanges.length, 2)

    assert.deepEqual(changes[0], [
      [ "bar", "baz" ],
      "foo"
    ])

    assert.notEqual(changes[0], initArr)
    assert.notEqual(changes[1], changes[0])
    assert.notEqual(changes[2], changes[1])
    assert.notEqual(changes[3], changes[2])

    assert.notEqual(innerChanges[0], initArr[1])
    assert.notEqual(innerChanges[1], innerChanges[0])

    assert.deepEqual(initArr, [
        "foo",
        ["bar", "baz"]
    ])

    assert.deepEqual(changes[1][0].slice(), ["bar2", "baz"])
    assert.equal(changes[1][1], "foo")

    assert.deepEqual(changes[2][0].slice(), ["bar2", "baz2"])
    assert.equal(changes[2][1], "foo")

    assert.equal(changes[3][1], "foo2")

    assert.deepEqual(initArr[1], ["bar", "baz"])
    assert.deepEqual(innerChanges[0].slice(), ["bar2", "baz"])
    assert.deepEqual(innerChanges[1].slice(), ["bar2", "baz2"])

    assert.equal(changes[0][1], changes[1][1],
        "unchanged properties are the same value")

    assert.end()
})

test("can call array methods on value inside reversed array", function (assert) {
    var arr = ObservArray([ Observ("foo"), Observ("bar") ])

    arr.reverse()

    var v = arr()

    var list = v.slice()
    var doubles = list.map(function (v) {
        return v + v
    })

    assert.ok(Array.isArray(v))
    assert.deepEqual(doubles, [ "barbar", "foofoo" ])

    assert.end()
})

test("can call array methods on reversed ObservArray", function (assert) {
    var arr = ObservArray([
        Observ(0),
        Observ(1),
        Observ(2),
        Observ(3),
        Observ(5)
    ])

    arr.reverse()

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

test("can add values to reversed observ array", function (assert) {
    var arr = ObservArray([
        Observ("foo"),
        Observ("bar")
    ])

    arr.reverse()

    var changes = []

    arr(function (state) {
        changes.push(state)
    })

    arr.push(Observ("baz"))
    arr.splice(1, 1)

    assert.equal(changes.length, 2)
    assert.deepEqual(changes[0].slice(), ["bar", "foo", "baz"])
    assert.deepEqual(changes[1].slice(), ["bar", "baz"])

    assert.end()
})

test("can add values to reversed observ array & listen", function (assert) {
    var arr = ObservArray([])
    var changes = []

    arr.reverse()

    arr(function (state) {
        changes.push(state)
    })

    arr.push(Observ("foo"))
    arr.push(Observ("bar"))

    arr.get(0).set("foo2")
    arr.get(1).set("bar2")

    assert.equal(changes.length, 4)

    assert.deepEqual(changes[0].slice(), ["foo"])
    assert.deepEqual(changes[1].slice(), ["foo", "bar"])
    assert.deepEqual(changes[2].slice(), ["foo2", "bar"])
    assert.deepEqual(changes[3].slice(), ["foo2", "bar2"])

    assert.end()
})

test("can use put to override existing value in reversed array", function (assert) {
    var arr = ObservArray([ Observ("foo"), Observ("bar") ])
    var changes = []

    arr.reverse()

    arr(function (state) {
        changes.push(state)
    })

    arr.put(0, Observ("baz"))
    arr.put(1, Observ("foobar"))

    assert.equal(changes.length, 2)
    assert.deepEqual(changes[0].slice(), ["baz", "foo"])
    assert.deepEqual(changes[0]._diff, [ [0, 1, "baz"] ])
    assert.deepEqual(changes[1].slice(), ["baz", "foobar"])
    assert.deepEqual(changes[1]._diff, [ [1, 1, "foobar"] ])

    assert.end()
})

test("can put values into reversed array beyond length", function (assert) {
    var arr = ObservArray([ Observ("foo"), Observ("bar") ])
    var changes = []

    arr.reverse()

    arr(function (state) {
        changes.push(state)
    })

    var baz = Observ("baz")
    arr.put(4, baz)

    baz.set("foobaz")

    assert.equal(changes.length, 2)
    assert.deepEqual(changes[0].slice(), ["bar", "foo", , , "baz"])
    assert.deepEqual(changes[0]._diff, [ [4, 0, "baz"] ])
    assert.deepEqual(changes[1].slice(), ["bar", "foo", , , "foobaz"])
    assert.deepEqual(changes[1]._diff, [ [4, 1, "foobaz"] ])

    assert.end()
})

test("batch changes with transactions on reversed array", function (assert) {

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

    arr.reverse()

    arr(function (state) {
        changes.push(state)
    })

    arr.transaction(function(rawList){
        rawList.push(items.foobar)
        rawList.splice(1, 1, items.baz, items.bazbar)
        rawList.unshift(items.foobaz)
        rawList[6] = items.foobarbaz
    })

    assert.equal(changes.length, 1)

    assert.deepEqual(changes[0].slice(), [
        "foobaz","bar","baz","bazbar","foobar", undefined, "foobarbaz"
    ])

    // check internal list
    assert.equal(arr._list.length, changes[0].length)
    changes[0].forEach(function(val, i){
        assert.equal(arr._list[i], items[val])
    })

    assert.deepEqual(changes[0]._diff, [
        [1,1,"baz","bazbar","foobar", undefined, "foobarbaz"],
        [0,0,"foobaz"]
    ])

    assert.end()
})

test("set updates reversed array rather than replacing observ value", function (assert) {

    var items = {
        foo: Observ("foo"),
        bar: Observ("bar"),
        foobar: Observ("foobar"),
        baz: Observ("baz"),
        bazbar: Observ("bazbar")
    }

    var arr = ObservArray([ items.foo, items.bar, items.baz ])
    var changes = []

    arr.reverse()

    arr(function (state) {
        changes.push(state)
    })

    assert.deepEqual(arr(), [ "baz", "bar", "foo" ])

    arr.set([ items.foo, items.foobar, items.baz, items.bazbar ])

    arr.reverse()

    assert.equal(changes.length, 2)

    assert.deepEqual(changes[0].slice(), [
        "foo","foobar","baz","bazbar"
    ])

    assert.deepEqual(changes[0]._diff, [
        [0, 3, "foo","foobar","baz","bazbar"]
    ])

    assert.deepEqual(changes[1].slice(), [
        "bazbar", "baz", "foobar", "foo"
    ])

    assert.deepEqual(changes[1]._diff, [
        [0, 4, "bazbar", "baz", "foobar", "foo" ]
    ])

    assert.end()
})

test("reverse preserves observables after reversing", function(assert) {
    var items = {
        foo: Observ("foo"),
        bar: Observ("foo"),
        foobar: Observ("foo"),
        baz: Observ("foo"),
        bazbar: Observ("foo")
    }

    var arr = ObservArray([ items.foo, items.bar, items.foobar ])

    var changes = []

    arr(function(state) {
      changes.push(state)
    })

    arr.reverse()

    items.foo.set("foo2")
    items.bar.set("bar")
    items.foobar.set("foobar")

    assert.equal(changes.length, 4)

    assert.deepEqual(changes[0].slice(), [
      "foo", "foo", "foo"
    ])
    assert.deepEqual(changes[0]._diff, [
      [ 0, 1, "foo" ],
      [ 2, 1, "foo" ]
    ])

    assert.deepEqual(changes[1], [
      "foo", "foo", "foo2"
    ])
    assert.deepEqual(changes[1]._diff, [
      [ 2, 1, "foo2" ]
    ])

    assert.deepEqual(changes[2], [
      "foo", "bar", "foo2"
    ])
    assert.deepEqual(changes[2]._diff, [
      [ 1, 1, "bar" ]
    ])

    assert.deepEqual(changes[3], [
      "foobar", "bar", "foo2"
    ])
    assert.deepEqual(changes[3]._diff, [
      [ 0, 1, "foobar" ]
    ])

    assert.end()
})
