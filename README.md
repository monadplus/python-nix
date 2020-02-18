### Python Development Environment

This project explains how to set up Nix + Python + Vim for python development with:

- Auto-complete
- Code audit
- Offline documentation

### Requirements

- git
- vim (with the corresponding .vimrc)
- nix
- direnv (latest version with use_nix in the stdlib)
- LSP for Python (python-language-server)
- Vim plugins:
  - direnv-vim
  - jedi-vim: offline docs / go to definition
  - YouCompleteMe: autocomplete
  - syntastic: linting

### Installation

1. Add jedi-vim, YouCompleteMe, and syntastic to your vim plugins (I use home-manager but you can do it manually).
2. Add the following line to .vimrc to prevent jedi-vim to autocomplete (jedi-vim doesn't work on big dependencies such as pandas):

```
let g:jedi#completions_enabled = 0
```

3. Install direnv in NixOS (on zsh you need to add the following line `eval "$(direnv hook zsh)"` to `.zshrc`).
4. Clone the template https://github.com/monadplus/python-template-nix and extract all files (you can delete the README).
5. `$ allow direnv .` which should trigger your .envrc configuration.
6. Open vim and enjoy (auto-complete takes longer the first time)

### How it works

When you enter in the directory, direnv will automatically trigger the script inside `.envrc`.

This script, among other things, runs your `shell.nix` which setups a python interpreter with all dependencies required to run low-level python dependencies written in c, creates a virtual environment using `venv` and install all dependencies in the virtual environment using `pip` (feel free to add more dependencies to requirements.txt). `pip` installs flake8 (code audit) and LSP for Python which are essential for this setup.

When direnv has finished loading the initial setup (the first time always takes longer), you can start coding. Open any `*.py` file and auto-complete should work out of the box for all your dependencies. The same for offline documentation. Code auditing is triggered by syntastic after the file is saved.

Enjoy your coding :-)

### Vim keybindings

Here are some useful commands for vim:

- Goto assignment `<leader>g` (typical goto function)
- Goto definition `<leader>d` (follow identifier as far as possible, includes imports and statements)
- Goto (typing) stub `<leader>s`
- Show Documentation `K` (shows a popup with assignments)
- Renaming `<leader>r`
- Usages `<leader>n` (shows all the usages of a name)
- Open module, e.g. `:Pyimport os` (opens the os module)

### Credit

The configuration started from a post on reddit: https://www.reddit.com/r/NixOS/comments/f4fvqp/nix_and_python/
