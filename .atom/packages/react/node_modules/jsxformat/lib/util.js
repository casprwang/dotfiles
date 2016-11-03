var _ = require('lodash');

function isInRange(node, range) {
  if (range) {
    var loc = node.loc;
    if (!loc) {
      return false;
    }

    var rangeStart = range[0];
    var rangeEnd = range[1];
    var start = _.values(loc.start);
    var end = _.values(loc.end);

    var startOk = false;;
    if (start[0] > rangeStart[0]) {
      startOk = true;
    } else if (start[0] === rangeStart[0]) {
      startOk = start[1] >= rangeStart[1];
    }

    var endOk;
    if (end[0] < rangeEnd[0]) {
      endOk = true;
    } else if (end[0] === rangeEnd[0]) { // Same row
      endOk = end[1] <= rangeEnd[1];
    }

    return startOk && endOk;
  }

  return true;
}


exports.isInRange = isInRange;
