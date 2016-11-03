'use strict';

var FormRequestHandler = require('./form.js');
var MethodRequestHandler = require('./method.js');

module.exports = methods;

function methods(routes, handleHttpForms) {
    return handleHttpForms ?
        FormRequestHandler(routes) :
        MethodRequestHandler(routes);
}
