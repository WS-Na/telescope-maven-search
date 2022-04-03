<a href="https://asciinema.org/a/0ziLkx1TQ7wWdHPsfHVcXV2nQ" target="_blank">
  <img src="https://asciinema.org/a/0ziLkx1TQ7wWdHPsfHVcXV2nQ.svg" height="200" align="right"/>
</a>

# telescope-maven-search

A [telescope](https://github.com/nvim-telescope/telescope.nvim)
extension to search dependencies in MavenCentral.

## Features:

- Search MavenCentral and copy artifact to clipboard.
- Works for any JVM language that has a build tools that can use deps
  from MavenCentral.

## Installation
With packer:

```lua
use 'aloussase/telescope-mvnsearch'
```

Then register the extension with telescope:

```lua
require'telescope'.load_extension('mvnsearch');
```

## Options
| Option | Description | Values
| -------|-------------|-------
| query | what to look for in maven central | string
| format | in what format to display the artifacts | string

## Formats
Currently the available artifact formats are:

- maven
- gradle
- leiningen
- sbt

Feel free to open an issue or a PR if you want more!.

## License

MIT
