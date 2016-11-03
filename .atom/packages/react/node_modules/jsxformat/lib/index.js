var rocambole = require('rocambole');

// Formatters
var attributes = require('./formatters/attributes');
var tags = require('./formatters/tags');

module.exports = {
  setOptions: function (opts) {
    attributes.setOptions(opts);
    tags.setOptions(opts);
  },
  nodeAfter: function(node) {
    attributes.nodeAfter(node);
    tags.nodeAfter(node);
  },
  format: function (str) {
    var ast = rocambole.parse(str, {loc: true});
    rocambole.walk(ast, this.nodeAfter);
    return ast.toString();
  }
};
