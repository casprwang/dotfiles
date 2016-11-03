# Options

Automatically generated documentation for Atom Beautify's options.

## Package Options

Configurable options for Atom Beautify.

---

{{#each packageOptions}}
{{> option-group}}
{{/each}}

## Language Options

Supported options for each language.

---

{{#each languageOptions}}
{{> option-group}}
{{/each}}

## Beautifier Options

Supported options for each beautifier.

---

{{#each beautifierOptions}}
### {{@key}}

{{#each this}}
{{> option}}
{{/each}}

{{/each}}
