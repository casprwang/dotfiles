'use babel';
import {startsWith} from './utils';

/**
 * @class Handles the mapping between projects and their package.json deps
 */
export default class ProjectDeps {
    constructor() {
        this._deps = Object.create(null);
    }

    clear() {
        this._deps = Object.create(null);
    }

    set(rootPath, deps) {
        this._deps[rootPath] = deps;
    }

    hasDeps(rootPath) {
        return rootPath in this._deps;
    }

    search(currPath, keyword) {
        const rootPaths = Object.keys(this._deps);
        let pathDeps = [];

        for (let i = 0; i < rootPaths.length; i++) {
            // for the current path to be a child of root, it must start with rootpath
            if (startsWith(currPath, rootPaths[i])) {
                pathDeps = this._deps[rootPaths[i]];
                break;
            }
        }

        return pathDeps.filter(d => startsWith(d, keyword));
    }
}
