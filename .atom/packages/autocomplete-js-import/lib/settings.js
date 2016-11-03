'use babel'

export default {
    projectDependencies: {
        type: 'object',
        title: 'Load project dependencies from package.json. Note: This can adversely affect load performance',
        properties: {
            suggestDev: {
                title: 'Suggest dev dependencies',
                type: 'boolean',
                default: false
            },
            suggestProd: {
                title: 'Suggest regular dependencies',
                type: 'boolean',
                default: false
            }
        }
    },
    fuzzy: {
        type: 'object',
        title: '(Experimental) Fuzzy file matching',
        properties: {
            enabled: {
                title: 'Enabled',
                type: 'boolean',
                default: false
            },
            excludedDirs: {
                title: 'Directories to omit from matching',
                type: 'array',
                default: ['node_modules', '.git']
            },
            fileTypes: {
                title: 'Allowable file types (* for anything)',
                type: 'array',
                default: ['ts', 'js', 'jsx', 'json']
            }
        }
    },
    importTypes: {
        type: 'object',
        title: 'Import types for autocompletion',
        properties: {
            es6: {
                type: 'boolean',
                default: true,
                title: 'ES6 style "Import"'
            },
            require: {
                type: 'boolean',
                default: true,
                title: 'Commonjs "require"'
            }
        }
    },
    hiddenFiles: {
        type: 'boolean',
        default: false,
        title: 'Show hidden files (files starting with ".") in suggestions'
    },
    removeExtensions: {
        type: 'array',
        default: ['.js'],
        title: 'Removes extension from suggestion',
        description: 'Import statements can usually autoresolve certain filetypes without providing an extension; '
            + 'this provides the option to drop the extension'
    }
}
