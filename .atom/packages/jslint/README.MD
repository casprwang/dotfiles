# JSLint

![](https://img.shields.io/apm/v/jslint.svg)
![](https://img.shields.io/apm/dm/jslint.svg)
![](https://img.shields.io/apm/l/jslint.svg)

> [JSLint](https://github.com/douglascrockford/JSLint) error reports for your [Atom](http://atom.io) editor.

![preview](https://cloud.githubusercontent.com/assets/145288/5823960/41af30f8-a0e1-11e4-814e-3f97c7a05599.png)

## Installation

You can install this plugin via the Packages manager in Atom itself or manually through the terminal

```bash
$ apm install jslint
```

## Usage

JSlint is by default validating on save (this can be changed in the package settings), you can also execute it by hitting `ctrl-alt-l`.

If you like you can even set it to validate while typing in the package settings.

## Configuration
JSlint options can be configured via `.jslintrc` config files, located in

 * your home directory *(global options)* and
 * your project root directory *(project specific options)*.

The `.jslintrc` config files are JSON files see [`.jslintrc-example`](.jslintrc-example) for an example.
Specifications of the different options can be found in the [JSlint documentation](http://www.jslint.com/help.html).


## Features

 * Validate on keymap
 * Validate on command
 * Validate on save *(toggle in settings)*
 * Validate on change *(toggle in settings)*
 * Option to hide the error panel if no errors were found *(toggle in settings)*
 * Option to use `fold mode` by default *(toggle in settings)*
 * Choose between different JSLint versions *(select in settings)*
 * Supports `.jslintrc` config files *(project located file will overwrite the global file)*
 * ES6 support *(you need to select es6 in the JSLint version dropdown and reload Atom)*

## License

[MIT](http://opensource.org/licenses/MIT) © tcarlsen
