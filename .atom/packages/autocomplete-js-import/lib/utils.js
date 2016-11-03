'use babel';

// These only match prefixes
const REQUIRE_REGEX = /require\(["']([^"']+)$/;
const ES6_REGEX = /(?:^import .*?|^}) from ["']([^"']+)$/;

export function capturedDependency(prefix, importTypes) {
    let results = null;

    if (importTypes.es6) {
        results = ES6_REGEX.exec(prefix);
    }

    if (!results && importTypes.require) {
        results = REQUIRE_REGEX.exec(prefix);
    }

    if (results && results.length) {
        return results[1];
    }

    return null;
}

// Taken from MDN
function escapeRegex(str) {
    return str.replace(/[.*+?^${}()|[\]\\]/g, "\\$&"); // $& means the whole matched string
}

export function startsWith(base, keyword) {
    const keywordRegex = new RegExp(`^${escapeRegex(keyword)}`);

    return keywordRegex.test(base);
}

export function endsWith(base, keyword) {
    const keywordRegex = new RegExp(`${escapeRegex(keyword)}$`);

    return keywordRegex.test(base);
}

/**
 * Returns a function that returns the logical negation of the given function's output
 */
export function not(func) {
    return function() {
        return !func(...arguments);
    };
}

// Used to check if a given string matches the constraints of NPM naming
// Algo basically taken from https://docs.npmjs.com/files/package.json
export function matchesNPMNaming(prefix) {
    if (encodeURIComponent(prefix) !== prefix) {
        return false;
    }

    // I don't check for capital letters so that I can still match even if user puts caps for some reason
    return /^[^._]/.test(prefix);
}

export function dropExtensions(fileName, extensions) {
    for (let i = 0; i < extensions.length; i++) {
        let ext = extensions[i];

        if (endsWith(fileName, ext)) {
            fileName = fileName.substring(0, fileName.length - ext.length);

            break;
        }
    }

    return fileName;
}

export function getDirAndFilePrefix(filePath) {
    const pathParts = filePath.split('/');
    const toComplete = pathParts.pop();

    return [pathParts.join('/'), toComplete];
}

export function getParentDir(filePath) {
    return getDirAndFilePrefix(filePath)[0];
}

export function isHiddenFile(fileName) {
    return startsWith(fileName, '.');
}
