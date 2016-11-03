'use strict';
'use babel';

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.Communication = undefined;
exports.create = create;
exports.createFromProcess = createFromProcess;
exports.fork = fork;
exports.forkFile = forkFile;

var _cluster = require('cluster');

var _cluster2 = _interopRequireDefault(_cluster);

var _child_process = require('child_process');

var _child_process2 = _interopRequireDefault(_child_process);

var _communication = require('./communication');

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function create() {
  return new _communication.Communication(process);
}

function createFromProcess(process) {
  return new _communication.Communication(process);
}

function fork(env) {
  return new _communication.Communication(_cluster2.default.fork(env || process.env));
}

function forkFile(filePath) {
  let args = arguments.length <= 1 || arguments[1] === undefined ? [] : arguments[1];
  let options = arguments.length <= 2 || arguments[2] === undefined ? {} : arguments[2];

  return new _communication.Communication(_child_process2.default.fork(filePath, args, options));
}

exports.Communication = _communication.Communication;