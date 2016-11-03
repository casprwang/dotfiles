'use babel'
import {Range, Point} from 'atom';
import {
    startsWith,
    capturedDependency,
    not,
    isHiddenFile,
    matchesNPMNaming,
    dropExtensions,
    getParentDir,
    getDirAndFilePrefix
 } from './utils';
import * as Fuzzy from 'fuzzy';
import path from 'path';
import fs from 'fs';

export default class ImportCompletionProvider {
    constructor(projectDeps, filesMap) {
        this.selector =  '.source.js, .source.ts';
        this.disableForSelector = '.source.js .comment, .source.ts .comment';
        // Include as higher priority than default auto complete suggestions
        this.inclusionPriority = 1;

        // Get search structures via Dependency injection
        this.projectDeps = projectDeps;
        this.filesMap = filesMap;
    }

    getSuggestions({editor, bufferPosition}) {
        return Promise.resolve()
            .then(() => {
                // TODO: this strategy won't work when the cursor is in the middle
                const prefix = this._getPrefix(editor, bufferPosition);
                const settings = atom.config.get('autocomplete-js-import');
                const packageName = capturedDependency(prefix, settings.importTypes);
                const results = [];

                if (!packageName) {
                    return results;
                }

                // checks for packages starting with name ../ or ./
                if (/^\.{1,2}\//.test(packageName)) {
                    const [inputtedRelativePath, toComplete] = getDirAndFilePrefix(packageName);
                    const currentDirPath = getParentDir(editor.getPath());
                    const absolutePath = path.resolve(currentDirPath, inputtedRelativePath);

                    return new Promise(resolve => {
                        fs.readdir(absolutePath, (err, files) => {
                            if (!files) {
                                return resolve([]);
                            }

                            let matchingFiles = files.filter(f => startsWith(f, toComplete));

                            if (!settings.hiddenFiles) {
                                matchingFiles = matchingFiles.filter(not(isHiddenFile));
                            }

                            resolve(matchingFiles.map(d => dropExtensions(d, settings.removeExtensions)))
                        });
                    }).catch(() => {/* shit happens */});
                } else if (matchesNPMNaming(packageName)) {
                    results.push(...this.projectDeps.search(editor.getPath(), packageName));
                }

                // This is last to give more precedence to package and local file name matches
                if (settings.fuzzy.enabled) {
                    results.push(...this._findInFiles(editor.getPath(), packageName, 6, settings.removeExtensions));
                }

                return results;
            })
            .then(completions => {
                // TODO: if part of the text is already present then replace the text or align it
                // ^ e.g in<cursor><enter>dex will result in index.jsdex instead of index.js
                if (completions && completions.length) {
                    return completions.map(c => {
                        const fullCompletion = {
                            type: 'import'
                        };

                        if (typeof c === 'string') {
                            fullCompletion.text = c;
                        } else {
                            Object.assign(fullCompletion, c);
                        }

                        return fullCompletion;
                    });
                }

                return [];
            })
            .catch(() => {
                // because shit happens and I need to get work done
            });
    }

    _getPrefix(editor, {row, column}) {
        const prefixRange = new Range(new Point(row, 0), new Point(row, column));

        return editor.getTextInBufferRange(prefixRange);
    }

    /**
     * @private
     * @param  {String} editorPath
     * @param  {String} stringPattern
     * @param  {Number} max
     * @param  {Array<String>} removeExtensionsSetting - array of extensions to remove from results
     * @return {Array<Object<text: String, displayText: String>>}
     */
    _findInFiles(editorPath, stringPattern, max, removeExtensionsSetting) {
        const rootDirs = atom.project.getDirectories();
        const containingRoot = rootDirs.find(dir => dir.contains(editorPath));
        const results = [];

        if (!containingRoot) {
            return results;
        }

        const targetFileList = this.filesMap.get(containingRoot.path);

        for (let i = 0; i < targetFileList.length && results.length < max; i++) {
            if (Fuzzy.test(stringPattern, targetFileList[i])) {
                const rootRelativePath = targetFileList[i];
                let currFileRelativePath = path.relative(
                    getParentDir(editorPath),
                    containingRoot.path + '/' + rootRelativePath
                );

                // TODO: I have no idea how buggy this is
                // path.relative doesn't add a './' for files in same directory
                if (/^[^.]/.test(currFileRelativePath)) {
                    currFileRelativePath = './' + currFileRelativePath;
                }

                currFileRelativePath = dropExtensions(currFileRelativePath, removeExtensionsSetting);

                // Show the full path because it lines up with what the user is typing,
                // but just insert the path relative to the user's current file
                results.push({text: currFileRelativePath, displayText: rootRelativePath});
            }
        }

        return results;
    }
}
