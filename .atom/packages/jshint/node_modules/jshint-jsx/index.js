'use strict';
var jshint = require('jshint').JSHINT,
    transformJSX = require('react-tools').transform,
    _ = require('lodash');

var jsxhint = (function() {
    function modifiedLines(a, b) {
        return _(a).zip(b).reduce(function(modified, lines, i) {
            if (lines[0] !== lines[1]) {
                modified[i] = true;
            }
            return modified;
        }, {});
    }

    var ignoreError = {
        'W064': true,
        'W101': function (line) {
            var maxlen = jshint.data().options.maxlen;
            return line.length <= maxlen;
        },
        'W102': true,
        'W109': true
    };

    function jsxhint() {
        var args = Array.prototype.slice.call(arguments),
            code = args[0],
            transformedCode,
            success = false,
            errors = [];

        try {
            args[0] = transformedCode = transformJSX(code);
        } catch (e) {
            // sometimes react-tools throws error without information about line
            if (e.lineNumber === undefined) {
                errors.push(null);
            } else {
                errors.push({
                    line: e.lineNumber,
                    character: e.column,
                    reason: e.description
                });
            }
        }

        if (_.isEmpty(errors)) {
            success = jshint.apply(null, args);
            errors = jshint.errors;
        }

        var originalLines = code.split('\n');
        var transformedLines = transformedCode ? transformedCode.split('\n') : [];
        var modified = transformedCode ? modifiedLines(originalLines, transformedLines) : {};

        // workaround the errors array sometimes containing `null`
        errors = _.compact(errors);

        jsxhint.errors = _.reject(errors, function(e) {
            var ignore = ignoreError[e.code];

            if (!modified[e.line - 1] || !ignore) {
                return false;
            }

            return _.isFunction(ignore) ?
                ignore(originalLines[e.line - 1], transformedLines[e.line - 1]) :
                true;
        });

        jsxhint.data = jshint.data;
        return success;
    }

    jsxhint.errors = [];

    return jsxhint;
})();

module.exports = {
    JSHINT: jshint,
    JSXHINT: jsxhint
};
