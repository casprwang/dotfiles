# jshint-json [![Build Status](https://travis-ci.org/sindresorhus/jshint-json.svg?branch=master)](https://travis-ci.org/sindresorhus/jshint-json)

> JSON reporter for [JSHint](https://github.com/jshint/jshint)

Makes it easy to use JSHint with other tools.


## Install

```sh
npm install --save-dev jshint-json
```


## Usage

Use it with:

#### JSHint CLI

```sh
$ jshint --reporter node_modules/jshint-json/json.js file.js
```

#### [grunt-contrib-jshint](https://github.com/gruntjs/grunt-contrib-jshint)

```js
grunt.initConfig({
	jshint: {
		options: {
			reporter: require('jshint-json')
		},
		target: ['file.js']
	}
});

grunt.loadNpmTasks('grunt-contrib-jshint');
grunt.registerTask('default', ['jshint']);
```


## Example output

```json
{
	"result": [{
		"file": "test.js",
		"error": {
			"id": "(error)",
			"raw": "'{a}' is not defined.",
			"code": "W117",
			"evidence": "describe('jshint-json', function () {",
			"line": 6,
			"character": 1,
			"scope": "(main)",
			"a": "describe",
			"reason": "'describe' is not defined."
		}
	}, {
		"file": "test.js",
		"error": {
			"id": "(error)",
			"raw": "'{a}' is not defined.",
			"code": "W117",
			"evidence": "\tit('should be used by JSHint', function () {",
			"line": 7,
			"character": 5,
			"scope": "(main)",
			"a": "it",
			"reason": "'it' is not defined."
		}
	}],
	"data": [{
		"functions": [{
			"name": "\"jshint-json\"",
			"line": 6,
			"character": 35,
			"last": 26,
			"lastcharacter": 2,
			"metrics": {
				"complexity": 1,
				"parameters": 0,
				"statements": 1
			}
		}, {
			"name": "\"should be used by JSHint\"",
			"line": 7,
			"character": 46,
			"last": 25,
			"lastcharacter": 6,
			"metrics": {
				"complexity": 1,
				"parameters": 0,
				"statements": 5
			}
		}],
		"options": {
			"node": true,
			"esnext": true,
			"bitwise": true,
			"camelcase": true,
			"curly": true,
			"eqeqeq": true,
			"immed": true,
			"indent": 4,
			"(explicitIndent)": true,
			"latedef": true,
			"newcap": true,
			"noarg": true,
			"quotmark": "single",
			"regexp": true,
			"undef": true,
			"unused": true,
			"strict": true,
			"trailing": true,
			"smarttabs": true,
			"maxerr": 50
		},
		"errors": [{
			"id": "(error)",
			"raw": "'{a}' is not defined.",
			"code": "W117",
			"evidence": "describe('jshint-json', function () {",
			"line": 6,
			"character": 1,
			"scope": "(main)",
			"a": "describe",
			"reason": "'describe' is not defined."
		}, {
			"id": "(error)",
			"raw": "'{a}' is not defined.",
			"code": "W117",
			"evidence": "\tit('should be used by JSHint', function () {",
			"line": 7,
			"character": 5,
			"scope": "(main)",
			"a": "it",
			"reason": "'it' is not defined."
		}],
		"implieds": [{
			"name": "describe",
			"line": [
				6
			]
		}, {
			"name": "it",
			"line": [
				7
			]
		}],
		"globals": [
			"assert",
			"require",
			"jshint",
			"jsonReporter",
			"console"
		],
		"member": {
			"run": 1,
			"reporter": 2,
			"log": 2,
			"args": 1
		},
		"file": "test.js"
	}]
}
```


## License

MIT © [Sindre Sorhus](http://sindresorhus.com)
