notifier = require '../../lib/notifier'
contextPackageFinder = require '../../lib/context-package-finder'
GitDifftoolContext = require '../../lib/models/git-difftool-context'

{repo} = require '../fixtures'
mockSelectedPath = 'selected/path'
contextCommandMap = jasmine.createSpy('contextCommandMap')

describe "GitDifftoolContext", ->
  describe "when an object in the tree is selected", ->
    it "calls contextCommandMap::map with 'DiffTool' and the filepath for the tree object", ->
      spyOn(contextPackageFinder, 'get').andReturn {selectedPath: mockSelectedPath}
      GitDifftoolContext repo, contextCommandMap
      expect(contextCommandMap).toHaveBeenCalledWith 'difftool', repo: repo, file: mockSelectedPath

  describe "when an object is not selected", ->
    it "notifies the userof the issue", ->
      spyOn(notifier, 'addInfo')
      GitDifftoolContext repo, contextCommandMap
      expect(notifier.addInfo).toHaveBeenCalledWith "No file selected to diff"
