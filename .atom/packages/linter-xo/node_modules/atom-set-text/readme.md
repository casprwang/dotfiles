# atom-set-text [![Build Status](https://travis-ci.org/sindresorhus/atom-set-text.svg?branch=master)](https://travis-ci.org/sindresorhus/atom-set-text)

> A better Atom [`TextEditor#setText()`](https://atom.io/docs/api/latest/TextEditor#instance-setText) that preserves cursor/scroll position and selections


## Install

```
$ npm install --save atom-set-text
```


## Usage

```js
/** @babel */
import setText from 'atom-set-text';

setText('new text');
```

## API

### setText(text, [editor])

#### text

Type: `string`

Text you want to set in the editor.

#### editor

Default: `atom.workspace.getActiveTextEditor()`

Editor to set the text in.


## License

MIT © [Sindre Sorhus](http://sindresorhus.com)
