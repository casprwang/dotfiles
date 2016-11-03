path = require 'path'
fs = require 'fs'
PugProvider = require '../lib/pug-provider'

describe "PugProvider", ->
  [provider] = []

  beforeEach ->
    provider = new PugProvider

  describe "transform", ->
    it "pug -> html", ->
      pugCode = fs.readFileSync(path.join(__dirname, 'fixtures', 'sample.pug'), encoding: 'utf8')
      htmlCode = fs.readFileSync(path.join(__dirname, 'fixtures', 'sample.html'), encoding: 'utf8')
      expect(provider.transform(pugCode).code.trim()).toEqual(htmlCode.trim())

    it "pug -> html with extends", ->
      pugFilePath = path.join(__dirname, 'fixtures', 'index.pug')
      pugCode = fs.readFileSync(pugFilePath, encoding: 'utf8')
      htmlCode = fs.readFileSync(path.join(__dirname, 'fixtures', 'index.html'), encoding: 'utf8')
      expect(provider.transform(pugCode, filePath: pugFilePath).code.trim()).toEqual(htmlCode.trim())
