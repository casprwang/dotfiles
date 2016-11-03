'use strict';

const assert = require('chai').assert;
const expect = require('chai').expect;

const promisify = require('../index.js');

describe('Promisification', function () {
  it('should promisify simple functions', function () {
    function fn (callback) {
      callback();
    }
    return promisify(fn)();
  });

  it('should promisify functions receiving args', function () {
    const data = 'some data';
    function fn (arg, callback) {
      expect(arg).to.equal(data);
      callback();
    }
    return promisify(fn)(data);
  });

  it('should promisify functions returning args', function () {
    const data = 'some data';
    function fn (callback) {
      callback(null, data);
    }
    return promisify(fn)().then(function (arg) {
      expect(arg).to.equal(data);
    });
  });

  it('should promisify complex functions', function () {
    const data1 = 'some data 1';
    const data2 = 'some data 2';
    const data3 = 'some data 3';
    const data4 = 'some data 4';
    function fn (arg1, arg2, callback) {
      expect(arg1).to.equal(data1);
      expect(arg2).to.equal(data2);
      callback(null, data3, data4);
    }
    return promisify(fn, {
      multiArgs: true
    })(data1, data2).then(function (args) {
      expect(args).to.deep.equal([data3, data4]);
    });
  });

  it('should manage errors', function () {
    const errorMsg = 'test error';
    function fn (callback) {
      callback(new Error(errorMsg));
    }
    return promisify(fn)().then(function () {
      assert.fail();
    }).catch(function (err) {
      expect(err.message).equals(errorMsg);
    });
  });

  it('should return an error if no function is given', function () {
    const errorMsg = 'first parameter is not a function';
    try {
      promisify({});
      assert.fail();
    } catch (err) {
      expect(err.message).equals(errorMsg);
    }
  });
});
