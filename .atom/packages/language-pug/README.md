# language-pug package

A [Pug](https://github.com/pugjs) (was **Jade**) syntax highlighting for Atom, derived from [jade-tmbundle](https://github.com/davidrios/jade-tmbundle).

### Development

This syntax is meant to be maintained and fixed in all his known bugs, it is used by the [Objectway](https://github.com/Objectway) front end team.

### Collaborate

Any improvement, suggestion, bugfix is really appreciated.

### Bugs

~~One pesky bug is the one involving comments that are not rendered properly~~

**Comment bug has been fixed in v0.0.13, although in an ugly way and needs to be refactored**

~~[FirstMate issue 38](https://github.com/atom/first-mate/issues/38)~~

~~Any help in fixing and improving this one is more than welcome!~~

Any help in giving this fix a less ugly face will be greatly appreciated.

### Install

`$ apm install language-pug`


### Configure

In your `config.cson` write:

```
".source.pug":
  whitespace:
    removeTrailingWhitespace: false
```

### License

This package is published under MIT license
