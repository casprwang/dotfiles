# linter-python-pep8 package

This **linter-python-pep8** plugin for [Linter](https://github.com/AtomLinter/Linter)
provides an interface to [pep8](https://pypi.python.org/pypi/pep8). It will
be used with files that have the Python syntax.

## Requirements
*Linter* package must be installed in order to use this plugin. If *Linter* is not
installed, please follow the instructions [here](https://github.com/AtomLinter/Linter).

### Installation
Before using this plugin, you should make sure that `pep8` is installed on your
system. You can follow following instructions to install `pep8`:

1. Install [python](https://www.python.org/).

2. Install [pep8](https://pypi.python.org/pypi/pep8) by typing the following
in a terminal:
   ```
   pip install pep8
   ```

Now you can proceed to install the **linter-python-pep8** plugin.

### Plugin installation
```
$ apm install linter-python-pep8
```

## Settings
You can configure *linter-python-pep8* by editing *~/.atom/config.cson* (choose *Open Your Config*
in *Atom* menu). You'll need to add the directory where your **pep8** executable
resides. Also, it's possible to indicate which errors you want to be ignored through
the *ignoreErrorCodes* configuration option:

Example:
```
'linter-python-pep8':
  'pep8DirToExecutable': '/usr/local/bin/'
  'ignoreErrorCodes': 'E501, W292'
```
