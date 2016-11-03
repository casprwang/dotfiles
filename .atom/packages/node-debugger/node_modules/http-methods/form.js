'use strict';

var contentTypes = require('content-types');
var jsonBody = require('body').json;
var formBody = require('body').form;

module.exports = FormRequestHandler;

function FormRequestHandler(methods) {
    return function formRequestHandler(req, res, opts, cb) {
        if (typeof cb !== 'function') {
            throw new Error('callback required');
        }

        var args = arguments;
        var self = this;

        contentTypes(req, res, {
            'application/json': jsonBody,
            'application/x-www-form-urlencoded': formBody,
            'default': callRequestHandler
        })(req, res, extractMethod);

        function callRequestHandler() {
            var method = req.method;
            var f = methods[method] || methods.notFound || notFound;

            return f.apply(self, arguments);
        }

        function extractMethod(err, body) {
            if (err) {
                err.statusCode = 400;
                return cb(err);
            }

            var method = body._method;
            var f = methods[method] || methods.notFound || notFound;

            return f.apply(self, args);
        }
    };
}

function notFound(req, res, opts, cb) {
    var err = new Error('405 Method Not Allowed ' + req.url);
    err.statusCode = 405;

    return cb(err);
}
