'use babel'
/* eslint-env jasmine */

import plugin from '../lib/index';

describe('lib/index.js', function() {
    describe('sanity checks', function() {
        // This is mostly to ensure that I added everything on the git commit
        it('should not explode upon loading', function() {
            expect(typeof plugin.config === 'object').toBe(true);
            expect(typeof plugin.activate === 'function').toBe(true);
            expect(typeof plugin.deactivate === 'function').toBe(true);
            expect(typeof plugin.provide === 'function').toBe(true);
        });
    });
});
