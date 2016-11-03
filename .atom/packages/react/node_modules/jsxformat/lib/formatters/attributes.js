var _ = require('lodash');
var utils = require('../util');

function newLine() {
  return {
    type: 'LineBreak',
    value: '\n' // TODO: load setting from options
  }
}

function tagAttributesTooLong(node) {
  var loc = node.loc;

  if (loc.start.line < loc.end.line) {
    // Attributes are already on multiple lines (lets try to cleanup what is left)
    return true;
  } else {
    var length = loc.end.column - loc.start.column;
    return length > 50;
  }

  return true;
}


// TODO move under util

function endsWithNewLine(str) {
  return /\n\s*$/.test(str);
}

function startWithNewLine(str) {
  return /^\s*\n$/.test(str);
}

function surroundedByText(node) {

  var textBefore = node.startToken.prev
  && node.startToken.prev.type === "XJSText"
  && !endsWithNewLine(node.startToken.prev.value);
  var textAfter = node.endToken.next
  && node.endToken.next.type === "XJSText"
  && !startWithNewLine(node.endToken.next.value);

  return (textBefore && textAfter) || (node.parent && node.parent.type === 'XJSElement' && surroundedByText(node.parent));
}

var _opts = {};

module.exports = {
  setOptions: function (opts) {
    _opts = opts;
  },
  nodeAfter: function(node) {
    if (node.type === "XJSOpeningElement" && utils.isInRange(node, _opts.range) && !surroundedByText(node)) {
      // Split attributes into multiple lines
      if (node.attributes.length > 1 && tagAttributesTooLong(node)) { // TODO make this a variable and check length as well
        if (node.name.endToken.next.type === "WhiteSpace") {
          node.name.endToken.next.type = "NewLine";
          node.name.endToken.next.value = "\n";
        }

        node.attributes.map(function (attribute) {
          var next = attribute.endToken.next;

          if (next.type === "WhiteSpace") {
            if (!(next.next && next.next.type === "Punctuator")) {
              next.type = "NewLine";
              next.value = "\n";
              //TODO add indent before
            }
          } else if (next.type === "XJSIdentifier") {
            before(next, newLine());
          }
        });
      }
    }
  }
};
