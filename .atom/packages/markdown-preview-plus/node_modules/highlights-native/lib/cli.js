(function() {
  var Highlights, fs, optimist, path;

  path = require('path');

  fs = require('fs-plus');

  optimist = require('optimist');

  Highlights = require('./highlights');

  module.exports = function() {
    var cli, fileContents, filePath, html, outputPath, version;
    cli = optimist.describe('h', 'Show this message').alias('h', 'help').describe('i', 'Path to file or folder of grammars to include').alias('i', 'include').string('i').describe('o', 'File path to write the HTML output to').alias('o', 'output').string('o').describe('s', 'Scope name of the grammar to use').alias('s', 'scope').string('s').describe('v', 'Output the version').alias('v', 'version').boolean('v').describe('f', 'File path to use for grammar detection when reading from stdin').alias('f', 'file-path').string('f');
    optimist.usage("Usage: highlights [options] [file]\n\nOutput the syntax highlighted HTML for a file.\n\nIf no input file is specified then the text to highlight is read from standard in.\n\nIf no output file is specified then the HTML is written to standard out.");
    if (cli.argv.help) {
      cli.showHelp();
      return;
    }
    if (cli.argv.version) {
      version = require('../package.json').version;
      console.log(version);
      return;
    }
    filePath = cli.argv._[0];
    outputPath = cli.argv.output;
    if (outputPath) {
      outputPath = path.resolve(outputPath);
    }
    if (filePath) {
      filePath = path.resolve(filePath);
      if (!fs.isFileSync(filePath)) {
        console.error("Specified path is not a file: " + filePath);
        process.exit(1);
        return;
      }
      html = new Highlights().highlightSync({
        filePath: filePath,
        scopeName: cli.argv.scope
      });
      if (outputPath) {
        return fs.writeFileSync(outputPath, html);
      } else {
        return console.log(html);
      }
    } else {
      filePath = cli.argv.f;
      process.stdin.resume();
      process.stdin.setEncoding('utf8');
      fileContents = '';
      process.stdin.on('data', function(chunk) {
        return fileContents += chunk.toString();
      });
      return process.stdin.on('end', function() {
        html = new Highlights().highlightSync({
          filePath: filePath,
          fileContents: fileContents,
          scopeName: cli.argv.scope
        });
        if (outputPath) {
          return fs.writeFileSync(outputPath, html);
        } else {
          return console.log(html);
        }
      });
    }
  };

}).call(this);
