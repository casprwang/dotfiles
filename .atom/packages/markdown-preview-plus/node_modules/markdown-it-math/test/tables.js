"use strict";

var path = require('path');
var generate = require('markdown-it-testgen');
var assert = require('assert');

describe('Tables with default delimiters', function() {
  var md = require('markdown-it')({
    html: true,
    langPrefix: '',
    typographer: true,
    linkify: true
  }).use(require('../'));

  generate(path.join(__dirname, 'fixtures/tables.txt'), md);
});

describe('Tables with non-default delimiters', function() {
  var md = require('markdown-it')({
    html: true,
    langPrefix: '',
    typographer: true,
    linkify: true
  }).use(require('../'), {
    inlineOpen: '$',
    inlineClose: '$',
    blockOpen: '$$',
    blockClose: '$$'
  });

  generate(path.join(__dirname, 'fixtures/tables.txt'), md);
});

describe('Tables with multiple non-default delimiters', function() {
  var md = require('markdown-it')({
    html: true,
    langPrefix: '',
    typographer: true,
    linkify: true
  }).use(require('../'), {
    inlineOpen: '$',
    inlineClose: '$',
    blockOpen: '$$',
    blockClose: '$$'
  }).use(require('../'), {
    inlineOpen: '\\(',
    inlineClose: '\\)',
    blockOpen: '\\[',
    blockClose: '\\]'
  });

  generate(path.join(__dirname, 'fixtures/tables.txt'), md);
});

describe("Parsing pipe inside inline maths delimiters `$`", function() {
  var md = require('markdown-it')()
    .use(require('../'), {
      inlineOpen: '$',
      inlineClose: '$',
      blockOpen: '$$',
      blockClose: '$$'
    });

  it('Should not delimit a column of a table', function() {
    var res1 = md.render('col a | col b\n--|--\n$P(A|B)$ | foo');
    assert.equal(res1, '<table>\n<thead>\n<tr>\n<th>col a</th>\n<th>col b</th>\n</tr>\n</thead>\n<tbody>\n<tr>\n<td><math><mi>P</mi><mfenced open="(" close=")"><mrow><mi>A</mi><mo stretchy="true">|</mo><mi>B</mi></mrow></mfenced></math></td>\n<td>foo</td>\n</tr>\n</tbody>\n</table>\n');
  });

  it('Should respect multiple inline math on the same row', function() {
    var res1 = md.render('col a | col b | col c\n--|--|--\n$P(A|B)$ | foo | $P(A|B)$');
    assert.equal(res1, '<table>\n<thead>\n<tr>\n<th>col a</th>\n<th>col b</th>\n<th>col c</th>\n</tr>\n</thead>\n<tbody>\n<tr>\n<td><math><mi>P</mi><mfenced open="(" close=")"><mrow><mi>A</mi><mo stretchy="true">|</mo><mi>B</mi></mrow></mfenced></math></td>\n<td>foo</td>\n<td><math><mi>P</mi><mfenced open="(" close=")"><mrow><mi>A</mi><mo stretchy="true">|</mo><mi>B</mi></mrow></mfenced></math></td>\n</tr>\n</tbody>\n</table>\n');
  });
});

describe("Parsing pipe inside inline maths delimiters `\\(`, `\\)`", function() {
  it('Should not delimit a column of a table', function() {
    var md = require('markdown-it')()
      .use(require('../'), {
        inlineOpen: '\\(',
        inlineClose: '\\)',
        blockOpen: '\\[',
        blockClose: '\\]'
      });

    var res1 = md.render('col a | col b\n--|--\n\\(P(A|B)\\) | foo');
    assert.equal(res1, '<table>\n<thead>\n<tr>\n<th>col a</th>\n<th>col b</th>\n</tr>\n</thead>\n<tbody>\n<tr>\n<td><math><mi>P</mi><mfenced open="(" close=")"><mrow><mi>A</mi><mo stretchy="true">|</mo><mi>B</mi></mrow></mfenced></math></td>\n<td>foo</td>\n</tr>\n</tbody>\n</table>\n');
  });
});

describe("Parsing pipe inside inline maths configured with multiple delimiters", function() {
  var md = require('markdown-it')()
    .use(require('../'), {
      inlineOpen: '$',
      inlineClose: '$',
      blockOpen: '$$',
      blockClose: '$$'
    }).use(require('../'), {
      inlineOpen: '\\(',
      inlineClose: '\\)',
      blockOpen: '\\[',
      blockClose: '\\]'
    });

  it('Should not delimit a column of a table for `$`', function() {
    var res1 = md.render('col a | col b\n--|--\n$P(A|B)$ | foo');
    assert.equal(res1, '<table>\n<thead>\n<tr>\n<th>col a</th>\n<th>col b</th>\n</tr>\n</thead>\n<tbody>\n<tr>\n<td><math><mi>P</mi><mfenced open="(" close=")"><mrow><mi>A</mi><mo stretchy="true">|</mo><mi>B</mi></mrow></mfenced></math></td>\n<td>foo</td>\n</tr>\n</tbody>\n</table>\n');
  });

  it('Should not delimit a column of a table for `\\(`, `\\)`', function() {
    var res1 = md.render('col a | col b\n--|--\n\\(P(A|B)\\) | foo');
    assert.equal(res1, '<table>\n<thead>\n<tr>\n<th>col a</th>\n<th>col b</th>\n</tr>\n</thead>\n<tbody>\n<tr>\n<td><math><mi>P</mi><mfenced open="(" close=")"><mrow><mi>A</mi><mo stretchy="true">|</mo><mi>B</mi></mrow></mfenced></math></td>\n<td>foo</td>\n</tr>\n</tbody>\n</table>\n');
  })
});

describe("Parsing pipe inside unclosed maths delimiter", function () {
  it("Should parse columns as if they were normal text", function () {
    var md = require('markdown-it')()
      .use(require('../'), {
        inlineOpen: '$',
        inlineClose: '$',
        blockOpen: '$$',
        blockClose: '$$'
      });

    var res1 = md.render('col a | col b\n--|--\n$P(A|B) | foo');
    assert.equal(res1, '<table>\n<thead>\n<tr>\n<th>col a</th>\n<th>col b</th>\n</tr>\n</thead>\n<tbody>\n<tr>\n<td>$P(A</td>\n<td>B)</td>\n</tr>\n</tbody>\n</table>\n');
  });
});

describe("Parsing pipe inside unopened maths delimiter", function () {
  it("Should parse columns as if they were normal text", function () {
    var md = require('markdown-it')()
      .use(require('../'), {
        inlineOpen: '$',
        inlineClose: '$',
        blockOpen: '$$',
        blockClose: '$$'
      });

    var res1 = md.render('col a | col b\n--|--\nP(A|B)$ | foo');
    assert.equal(res1, '<table>\n<thead>\n<tr>\n<th>col a</th>\n<th>col b</th>\n</tr>\n</thead>\n<tbody>\n<tr>\n<td>P(A</td>\n<td>B)$</td>\n</tr>\n</tbody>\n</table>\n');
  });
});
