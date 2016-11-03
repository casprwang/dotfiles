# autocomplete-js-import
Autocomplete+ provider for JS import statements

Autocompletes ES6 or CommonJS (node) style import statements with relative file matching, full project fuzzy file matching or packages found in `package.json`.

By default, plugin will only allow autocompletion in the form of relative paths:

![import local files screenshot](https://raw.githubusercontent.com/DanielGarcia-Carrillo/autocomplete-js-import/master/misc/autocomplete-screenshot.png)

New Fuzzy matching (disabled by default)

![](https://raw.githubusercontent.com/DanielGarcia-Carrillo/autocomplete-js-import/master/misc/fuzzy-matching.gif)

# Additional features
* When project dependencies autocompletion is enabled, every root `package.json` is watched for changes
* Autocomplete hidden (dot) files
* Automatically remove unnecessary extensions (e.g. `./index.js` => `./index`) 


# TODO / Known Issues
* Fuzzy pattern matching doesn't work with files added/removed after project is added
* Attempting to fuzzy search with slashes or periods inserts suggestion incorrectly
