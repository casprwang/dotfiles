'use strict';

var test = require('tape')
var methods = require('..')
var testServer = require('test-server')

testServer(handleRequest, startTests)

function handleRequest(req, res) {
    var get = endValue('get');
    var post = endValue('post');
    var put = endValue('put');
    var del = endValue('del');

    if (req.url === '/form') {
        return methods({
            'GET': get,
            'POST': post,
            'PUT': put,
            'DELETE': del
        }, true).call(this, req, res, {}, sendError);
    } else if (req.url === '/no-callback') {
        try {
            methods({
                'GET': get,
                'POST': post,
                'PUT': put,
                'DELETE': del
            }).call(this, req, res);
        } catch (err) {
            return sendError(err);
        }
    } else if (req.url === '/empty-arg') {
        try {
            methods().call(this, req, res);
        } catch (err) {
            return sendError(err);
        }
    }

    methods({
        'PUT': put,
        'GET': get,
        'POST': post
    }).call(this, req, res, {}, sendError);

    function sendError(err) {
        if (err) {
            res.statusCode = err.statusCode || 500;
            res.end(err.message);
        }
    }
}

function endValue(value) {
    return function (req, res) { res.end(value) }
}

function startTests(request, done) {
    test('throws without cb', function (t) {
        request('/no-callback', function (err, res, body) {
            t.ifError(err);

            t.equal(res.statusCode, 500);
            t.equal(res.body, 'callback required');

            t.end();
        })
    })

    test('throws without opts', function (t) {
        request('/empty-arg', function (err, res, body) {
            t.ifError(err);

            t.equal(res.statusCode, 500);
            t.equal(res.body, 'methods must be an object');

            t.end();
        })
    })

    test('get', function (t) {
        request('/', testMethod('get', t))
    })

    test('post', function (t) {
        request({
            uri: '/'
            , method: 'POST'
        }, testMethod('post', t))
    })

    test('put', function (t) {
        request({
            uri: '/'
            , method: 'PUT'
        }, testMethod('put', t))
    })

    test('form get', function (t) {
        request('/form', testMethod('get', t))
    })

    test('form post', function (t) {
        request({
            uri: '/form'
            , method: 'POST'
        }, testMethod('post', t))
    })

    test('form put', function (t) {
        request({
            uri: '/form'
            , method: 'POST'
            , form: {
                _method: 'PUT'
            }
        }, testMethod('put', t))
    })

    test('form delete', function (t) {
        request({
            uri: '/form'
            , method: 'POST'
            , form: {
                _method: 'DELETE'
            }
        }, testMethod('del', t))
    })

    test('error', function (t) {
        request({
            uri: '/'
            , method: 'DELETE'
        }, function (err, res, body) {
            t.equal(res.statusCode, 405)
            t.equal(body, '405 Method Not Allowed /')

            t.end()
        })
    })

    .on('end', done)
}

function testMethod(value, t) {
    return function (err, res, body) {
        t.equal(body, value)

        t.end()
    }
}
