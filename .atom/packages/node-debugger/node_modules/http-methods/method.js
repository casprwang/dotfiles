'use strict';

module.exports = MethodRequestHandler;

function MethodRequestHandler(methods) {
    if (methods === null || typeof methods !== 'object') {
        throw new Error('methods must be an object');
    }

    return function methodRequestHandler(req, res, opts, cb) {
        if (typeof cb !== 'function') {
            throw new Error('callback required');
        }

        var method = req.method;
        var f = methods[method] || methods.notFound || notFound;

        return f.apply(this, arguments);
    };
}

function notFound(req, res, opts, cb) {
    var err = new Error('405 Method Not Allowed ' + req.url);
    err.statusCode = 405;

    return cb(err);
}
