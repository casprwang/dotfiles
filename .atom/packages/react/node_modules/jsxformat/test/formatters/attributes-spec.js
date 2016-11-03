var should = require('chai').should()
var fs = require('fs');

var formatter = require('../../lib/index');

describe('Formatters - Attributes', function() {
  it('should split multiple attributes in to own lines in self closing tag if tag length is more than 50 characters', function () {
    var test = '<div foo="foo" bar="bar" baz="baz" baz1="baz" baz2="baz" baz3="baz" />';

    formatter.setOptions({});
    var result = formatter.format(test);
    var lines = result.split('\n');

    lines[0].trim().should.equal('<div');
    lines[1].trim().should.equal('foo="foo"');
    lines[2].trim().should.equal('bar="bar"');
    lines[3].trim().should.equal('baz="baz"');
    lines[4].trim().should.equal('baz1="baz"');
    lines[5].trim().should.equal('baz2="baz"');
    lines[6].trim().should.equal('baz3="baz" />');
  });

  it('should split multiple attributes in to own lines in opening tag if tag length is more than 50 characters', function () {
    var test = '<div foo="foo" bar="bar" baz="baz" baz1="baz" baz2="baz" baz3="baz"></div>';

    formatter.setOptions({});
    var result = formatter.format(test);
    var lines = result.split('\n');

    lines[0].trim().should.equal('<div');
    lines[1].trim().should.equal('foo="foo"');
    lines[2].trim().should.equal('bar="bar"');
    lines[3].trim().should.equal('baz="baz"');
    lines[4].trim().should.equal('baz1="baz"');
    lines[5].trim().should.equal('baz2="baz"');
    lines[6].trim().should.equal('baz3="baz">');
  });

  it('should split multiple attributes in to own lines if one attribute already is splitted', function () {
    var test = '<div foo="foo"\nbar="bar"></div>';

    formatter.setOptions({});
    var result = formatter.format(test);
    var lines = result.split('\n');

    lines[0].trim().should.equal('<div');
    lines[1].trim().should.equal('foo="foo"');
    lines[2].trim().should.equal('bar="bar">');
  });
});
