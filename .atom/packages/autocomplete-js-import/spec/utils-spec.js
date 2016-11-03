'use babel'
/* eslint-env jasmine */

import {
    capturedDependency,
    getDirAndFilePrefix,
    getParentDir
} from '../lib/utils';

function expectCorrectMatches(statement, packageName, config={es6: true, require: true}) {
    expect(capturedDependency(statement, config)).toEqual(packageName);
}

describe('Utils', function() {
    describe('capturedDependency', function() {
        const defaultPackageName = 'package-a_x';

        it('handles default import', function() {
            const statement = `import x_a from "${defaultPackageName}`;

            expectCorrectMatches(statement, defaultPackageName);
        });

        it('rejects when cursor is after "', function() {
            let statement = `import x_a from "${defaultPackageName}"`;

            expectCorrectMatches(statement, null);

            statement = `require('${defaultPackageName}'`
            expectCorrectMatches(statement, null);

            statement += ')';
            expectCorrectMatches(statement, null);
        });

        it('handles require', function() {
            const statement = `require('${defaultPackageName}`;

            expectCorrectMatches(statement, defaultPackageName);
        });

        it('handles many package name types', function() {
            [
                'package-a',
                'package_b',
                'package.util',
                '../../lib/index.js',
                './stuff/blah'
            ].forEach(packageName => {
                [
                    `import x from "${packageName}`,
                    `import x from '${packageName}`
                ].forEach(importStatement => {
                    expectCorrectMatches(importStatement, packageName);
                });
            });
        });

        it(`handles 'as' imports`, function() {
            let statement = `import * as x from '${defaultPackageName}`;

            expectCorrectMatches(statement, defaultPackageName);

            statement = `import {x_a as someFunc} from '${defaultPackageName}`;
            expectCorrectMatches(statement, defaultPackageName);
        });

        it('handles destructuring import', function() {
            const statement = `import {x_a} from "${defaultPackageName}`;

            expectCorrectMatches(statement, defaultPackageName);
        });

        it('handles inlined multi imports', function() {
            let statement = `import def, {x_a} from "${defaultPackageName}`;

            expectCorrectMatches(statement, defaultPackageName);

            statement = `import {x_a, x_b} from "${defaultPackageName}`;
            expectCorrectMatches(statement, defaultPackageName);
        });

        it('handles multiline import statement', function() {
            // Regex is only meant for prefix so this only tests against last line of import statement
            const importStatement = `} from "${defaultPackageName}`;

            expectCorrectMatches(importStatement, defaultPackageName);
        });
    });

    describe('getParentDir', function() {
        it('does what it\'s supposed to', function () {
            expect(getParentDir('../file/thing')).toEqual('../file');
        });
    });

    describe('getDirAndFilePrefix', function() {
        it('handles absolute paths', function () {
            const result = getDirAndFilePrefix('/home/user/daniel/file');

            expect(result.length).toBe(2);
            expect(result[0]).toEqual('/home/user/daniel');
            expect(result[1]).toEqual('file');
        });

        it('handles relative paths', function () {
            const dir = '../../dir/..';
            const file = 'a';
            const result = getDirAndFilePrefix(dir + '/' + file);

            expect(result.length).toBe(2);
            expect(result[0]).toEqual(dir);
            expect(result[1]).toEqual(file);
        });

        it('handles no file without exploding', function() {
            const result = getDirAndFilePrefix('../');

            expect(result.length).toEqual(2);
            expect(result[0]).toEqual('..');
            expect(result[1]).toEqual('');
        });
    });
});
