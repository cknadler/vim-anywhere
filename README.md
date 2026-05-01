# vim-anywhere

[![CI](https://github.com/cknadler/vim-anywhere/actions/workflows/ci.yml/badge.svg)](https://github.com/cknadler/vim-anywhere/actions/workflows/ci.yml)

Sometimes, you edit text outside of Vim. These are sad times. Enter
vim-anywhere!

![demo](assets/demo.gif)

Once [invoked](#keybinding), vim-anywhere will open a buffer. Close it and its
contents are copied to your __clipboard__ and your previous application is
refocused.

## Installation

#### Requirements

__macOS:__

- MacVim (`brew install --cask macvim`)

__Linux:__

- Gnome (or a derivative)
- gVim

#### Install

```bash
curl -fsSL https://raw.github.com/cknadler/vim-anywhere/master/install | bash
```

#### Update

```bash
~/.vim-anywhere/update
```

#### Uninstall

```bash
~/.vim-anywhere/uninstall
```

## Keybinding

__macOS:__ ( default = `ctrl+cmd+v` )

You can adjust the shortcut via [System Settings](assets/shortcut.png).

```
System Settings > Keyboard > Keyboard Shortcuts > Services > Vim Anywhere
```

__Linux:__ ( default = `ctrl+alt+v` )

*Gnome*
```bash
$ gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/vim-anywhere/ binding '<Primary><Alt>v'
```

*I3WM*

```bash
$ echo 'bindsym $mod+Alt+v exec ~/.vim-anywhere/bin/run' >> ~/.i3/config # remember to reload your config after
```
Adjust in case `$mod` is not set to ctrl.

## History

vim-anywhere creates a temporary file in `$TMPDIR/vim-anywhere` (macOS) or
`/tmp/vim-anywhere` (Linux) when invoked. These files stick around until you
restart your system, giving you a temporary history.

View your history:

```bash
$ ls ${TMPDIR:-/tmp}/vim-anywhere
```

Reopen your most recent file:

```bash
$ vim $( ls ${TMPDIR:-/tmp}/vim-anywhere | sort -r | head -n 1 )
```

## Why?

I use Vim for _almost_ everything. I wish I didn't have to say _almost_. My
usual workflow is to open Vim, write, copy the text out of my current buffer
and paste it into whatever application I was just using. vim-anywhere attempts
to automate this process as much as possible, reducing the friction of using
Vim to do more than just edit code.

## Bugs

First, make sure to [read the FAQ](FAQ.md). If you don't find the answer you're
looking for there, feel free to open an issue.

## [Contributing](CONTRIBUTING.md)

Pull requests, suggestions and issues of any kind are welcome. **Make sure
to check out the [contribution guidelines](CONTRIBUTING.md) before you submit a
pull request.**

## License

MIT.
