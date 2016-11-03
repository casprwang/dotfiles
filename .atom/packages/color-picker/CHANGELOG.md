# Change log

https://github.com/thomaslindstrom/color-picker

## v2.1.0
- Expose opening the `color-picker` as a service

### v2.1.1
- [Probably fix](https://github.com/thomaslindstrom/color-picker/commit/a0a3c43afac9407ccbc95733113014b695d1387a) [the one bug report that has been occurring over and over again](https://github.com/thomaslindstrom/color-picker/issues/114) for the past half year or so

## v2.0.0
- Completely rewritten source code
- Easily convert between color formats in the Color Picker UI
- Improved speed, performance and precision
- Improved design: Now properly handles awkward positions
- Add setting for preferred color format
- Add setting for deciding what trigger key should open the Color Picker
- Add setting for whether or not to serve a random color on open
- Add setting for, if possible, abbreviating color values
- Add setting for uppercasing color values
- Add setting for automatically updating the color value in editor on change

### v2.0.1
- Fix missing preview image

### v2.0.2
- Fix `keymap` deprecation
- Improve editor scroll binding

### v2.0.3
- `Return` element was being unnecessarily rendered
- Prevent sporadic `Format` element flicker
- Better output abbreviation
- Add Stylus variable support – *if they are preceded by `$`*
- Stop mistakingly assuming color variables in unrelated files
- *Behind the scenes* improvements

### v2.0.4
- Remove Atom Module Cache from `package.json`

### v2.0.5
- Set or replace color on key press `enter`

### v2.0.6
- Opacity values equaling `1.0` would in some cases not be read
- Fix issue where disabling the Shadow DOM would trigger a ton of bugs

### v2.0.7
- Fix issues with placement when using `Split View`

### v2.0.8
- Minor enhancements

### v2.0.9
- Fix Atom version dependency

### v2.0.10
- Avoid multiple of the same rendering in elements: Results in a snappier experience

### v2.0.11
- Fix issue where the Color Picker, in some cases, wouldn't open

### v2.0.12
- Fix issue where CSS 3D layering had broken “return” element in a recent Atom update

### v2.0.13
- Update Atom version dependency
- Replace deprecated functions

## v1.7.0
- Fix deprecations

## v1.6.0
- Fix deprecations

## v1.5.0
- Move stylesheets to `/styles` directory
- Replace deprecated `Atom View`, add dependency

## v1.4.4
- Fix a bug where clicking a color pointer that lead to the active file didn't scroll to the definition

## v1.4.3
- Remove `event-kit` dependency as it took a long time to activate
- Tidy up some bits of code

## v1.4.2
- Patch package. Uploading v.1.4.1 failed

## v1.4.1
- Close color picker on editor scroll
- Set up a `CHANGELOG.md`
