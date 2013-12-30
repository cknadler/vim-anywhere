# vim-anywhere

Sometimes...you edit text outside of Vim. These are sad times. Enter
vim-anywhere!

![demo](demo.gif)

vim-anywhere allows you to map a key to quickly open a MacVim buffer. Close it
and it's contents are copied to your clipboard and your previous application is
refocused.

## Installation

__Install:__

```bash
curl -fsSL https://raw.github.com/cknadler/vim-anywhere/master/install | sh
```

Once installation finishes, your keyboard preferences will be opened. Define
a shortcut for `VimAnywhere` under `Services` and you are good to go.

__Update:__

```bash
curl -fsSL https://raw.github.com/cknadler/vim-anywhere/master/update | sh
```

__Uninstall:__

```bash
curl -fsSL https://raw.github.com/cknadler/vim-anywhere/master/uninstall | sh
```

## Why?

I use Vim for _almost_ everything. I want to get rid of the _almost_. My usual
workflow is to open Vim, copy the text out of my current buffer and paste it
into whatever applicaiton I was just using. vim-anywhere attempts to automate
this process as much as possible, reducing the friction of popping open Vim on
the fly.

## Roadmap

- &#x2610; Find a way to automate setting vim-anywhere's keyboard shortcut
- &#x2610; Add GVim (and Linux) support
- &#x2610; Speed up opening MacVim (disable animations?)

## License

MIT.
