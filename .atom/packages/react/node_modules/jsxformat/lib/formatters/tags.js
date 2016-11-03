var rt = require('rocambole-token');
var _ = require('lodash');
var _s = require('underscore.string');
var utils = require('../util');

var _opts = {};

function newLine() {
  return {
    type: 'LineBreak',
    value: '\n' // TODO: load setting from options
  }
}

function textOnlyContainsWhiteSpacesAndNewLines(str) {
  return str.trim().length === 0;
}

function removeTrailingWhiteSpaces(str) {
  return str.replace(/ +$/, '');
}

function removeSpaces(str) {
  return str.replace(/\ /g, '');
}

function getPrevNonWhitSpace(token) {
  while (token.prev && token.prev.type === "WhiteSpace") {
    token = token.prev;
  }

  return token.prev;
}

function getNextNonWhitSpace(token) {
  while (token.next && token.next.type === "WhiteSpace") {
    token = token.next;
  }

  return token.next;
}

function removePrevWhiteSpaces(token) {
  var start = getPrevNonWhitSpace(token);
  rt.removeInBetween(start, token, function (token) {
    return token.type === "WhiteSpace";
  });
}

function removeNextWhiteSpaces(token) {
  var end = getNextNonWhitSpace(token);
  if (end.prev.type === "WhiteSpace") {
    rt.removeInBetween(token, end, function (token) {
      return token.type === "WhiteSpace";
    });
  }
}


function canAddAfter(token, node) {
  var nextToken = token.next;

  if (!nextToken) {
    return false;
  }

  if (nextToken.type === "Punctuator") {
    return true;
  } else if (nextToken.type === "XJSText") {
    var value = nextToken.value;
    if (textOnlyContainsWhiteSpacesAndNewLines(value)) {
      return true;
    } else if (_s.startsWith(value, "\n")) {
      return true;
    } else if (_s.startsWith(value, " ")) {
      return false;
    } else if (value.split(' ').length > 1) {
      return true;
    }
  } else if (nextToken.type === "LineBreak") {
    return true;
  } else if (nextToken.type === "WhiteSpace") {
    return true;
  }

  return false;
}

function canAddBefore(token, node) {
  var prevToken = token.prev;

  if (!prevToken) {
    return false;
  }

  if (prevToken.type === "Punctuator") {
    return true;
  } else if (prevToken.type === "XJSText") {
    var value = prevToken.value;
    if (textOnlyContainsWhiteSpacesAndNewLines(value)) {
      return true;
    } else if (_s.endsWith(value, "\n")) {
      return true;
    } else if (_s.endsWith(value, " ")) {
      return false;
    } else if (value.split(' ').length > 1) {
      return true;
    }
  } else if (prevToken.type === "LineBreak") {
    return true;
  } else if (prevToken.type === "WhiteSpace") {
    var prevNonWhiteSpace = getPrevNonWhitSpace(prevToken);
    return !prevNonWhiteSpace || prevNonWhiteSpace.type !== 'Keyword';
  }

  return false;
}

function before(token, tokenToAdd) {
  if (token &&
    token.prev &&
    token.prev.type !== "LineBreak") {
    if (token.prev.type === "XJSText") {
      if (!_s.endsWith(removeSpaces(token.prev.value), '\n')) {
        token.prev.value = removeTrailingWhiteSpaces(token.prev.value) + "\n";
      }
    } else {
      var prevNonWhiteSpace = getPrevNonWhitSpace(token);
      if (prevNonWhiteSpace.type !== "LineBreak") {
        removePrevWhiteSpaces(token);
        rt.before(token, tokenToAdd);
      }
    }
  }
}

function after(token, tokenToAdd) {
  if (token &&
    token.next &&
    token.next.type !== "LineBreak") {
      if (token.next.type === "XJSText") {
        if (!_s.startsWith(removeSpaces(token.next.value), '\n')) {
          token.next.value = "\n" + token.next.value;
        }
      } else {
        var nextNonWhiteSpace = getNextNonWhitSpace(token);
        if (nextNonWhiteSpace.type !== "LineBreak") {
          removeNextWhiteSpaces(token);
          rt.after(token, tokenToAdd);
        }
      }
  }
}

// TODO move under util

function endsWithNewLine(str) {
  return /\n\s*$/.test(str);
}

function startWithNewLine(str) {
  return /^\s*\n$/.test(str);
}

function surroundedByText(node) {

  var openingElement = node.openingElement;
  var closingElement = node.closingElement || node.openingElement;

  var textBefore = openingElement.startToken.prev
  && openingElement.startToken.prev.type === "XJSText"
  && !endsWithNewLine(openingElement.startToken.prev.value);
  var textAfter = closingElement.endToken.next
  && closingElement.endToken.next.type === "XJSText"
  && !startWithNewLine(closingElement.endToken.next.value);

  return (textBefore && textAfter) || (node.parent && node.parent.type === 'XJSElement' && surroundedByText(node.parent));
}

function textAsSibling(node) {
  return _.find(node.parent.children, function (node) {
    return node.type === "XJSText";
  });
}

function isAObjectProperty(node) {
  var type = node.parent && node.parent.type;
  return type === "Property";
}

function isFunctionParameter(node) {
  var type = node.parent && node.parent.type;
  return type === "CallExpression";
}

function formatFunctionParameters(node) {
  var length = node.parent.arguments.length;
  _.each(node.parent.arguments, function (arg, i) {
    before(arg.startToken, newLine());

    if (i === length - 1) {
      after(arg.endToken, newLine());
    }
  });
}

function canFormat(node) {
  return utils.isInRange(node, _opts.range) &&
         !isAObjectProperty(node) &&
         !surroundedByText(node);
}

module.exports = {
  setOptions: function (opts) {
    _opts = opts;
  },
  nodeAfter: function(node) {
    if (node.type === "XJSElement" && canFormat(node)) {

      if (node.closingElement) {

        if (canAddAfter(node.openingElement.endToken, node) &&
          canAddBefore(node.closingElement.startToken, node)) {
          /*
          <div>|foo</div>
          */
          after(node.openingElement.endToken, newLine());

          /*
          <div>foo|</div>
          */
          before(node.closingElement.startToken, newLine());
        }


        if (canAddBefore(node.openingElement.startToken, node) &&
          canAddAfter(node.closingElement.endToken, node)) {

          if (!isFunctionParameter(node)) {
            /*
            |<div>foo</div>
            */
            before(node.openingElement.startToken, newLine());

            /*
            <div>foo</div>|
            */
            after(node.closingElement.endToken, newLine());

          } else {
            formatFunctionParameters(node);
          }

        }
      } else if (!textAsSibling(node)) {
        if (canAddBefore(node.openingElement.startToken, node) &&
          canAddAfter(node.openingElement.endToken, node)) {

          if (!isFunctionParameter(node)) {
            before(node.openingElement.startToken, newLine());
            after(node.openingElement.endToken, newLine());
          } else {
            formatFunctionParameters(node);
          }
        }
      }
    }
  }
};
