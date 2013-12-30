# vim-anywhere

Sometimes, you edit text outside of Vim. These are sad times. It should be
easier to use Vim for more than just code...and now it is!

![demo](assets/demo.gif)

Map vim-anywhere to the key combination of your choice. Once invoked, it will
open a buffer in MacVim. Close it and it's contents are copied to your
clipboard and your previous application is refocused.

## Installation

__Install:__

```bash
curl -fsSL https://raw.github.com/cknadler/vim-anywhere/master/install | sh
```

Once installation finishes, your keyboard preferences will be opened. Define
a shortcut for `VimAnywhere` under `Services` and you are good to go.

![keyboard shortcut](assets/shortcut.png)

__Update:__

```bash
curl -fsSL https://raw.github.com/cknadler/vim-anywhere/master/update | sh
```

__Uninstall:__

```bash
curl -fsSL https://raw.github.com/cknadler/vim-anywhere/master/uninstall | sh
```

## Requirements

vim-anywhere requires [homebrew](http://brew.sh/) and the homebrew installation
of MacVim. The installer will attempt to install MacVim if you haven't already.

Right now, vim-anywhere is only for OSX. I'd love to support GVim and Linux in
the future.

## Why?

I use Vim for _almost_ everything. I wish I didn't have to say _almost_. My
usual workflow is to open Vim, write, copy the text out of my current buffer
and paste it into whatever applicaiton I was just using. vim-anywhere attempts
to automate this process as much as possible, reducing the friction of using
Vim to do more than just edit code.

## How does it work?

vim-anywhere creates a temporary file in `/private/tmp/vim-anywhere` when
invoked. This file sticks around until you restart your system.

You can list all of your recent invocations with:

```bash
$ ls /private/tmp/vim-anywhere
```

Reopen your most recent invocation:

```bash
$ vim $( ls /private/tmp/vim-anywhere | sort -r | head -n 1 )
```

## Roadmap

- &#x2610; Find a way to automate setting vim-anywhere's keyboard shortcut
- &#x2610; Add GVim (and Linux) support
- &#x2610; Speed up opening MacVim (disable animations?)

## Contributing

Love vim-anywhere? Hate it? Want to change it completely? Email me or open and
issue and lets talk. Pull requests, suggestions and issues of any kind are
welcome with open arms.

## License

MIT.
