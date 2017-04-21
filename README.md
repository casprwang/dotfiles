# Dotfiles

<h1 align="center">
	<br>
	<img width="400" src="https://cdn.rawgit.com/wangsongiam/dotfiles/c8b54909/demos/dotfiles-1.svg" alt="dotfiles">
	<br>
	<br>
	<br>
</h1>

![image](https://cloud.githubusercontent.com/assets/19645990/24074609/5ec34562-0be2-11e7-8821-8140c0711f0d.png)

## Configurations for:
* Neovim 
* Tmux
* iTerm
* Zsh
* Hammerspoon 
* Alfred 3

## Installation

make sure you know what [this](https://github.com/wangsongiam/dotfiles/blob/master/install.sh) means and have git installed

```
$ curl -fsSL https://raw.githubusercontent.com/wangsongiam/dotfiles/master/install.sh | sh
```

## Core files
* Neovim [init.vim](https://github.com/wangsongiam/dotfiles/blob/master/nvim/init.vim)
* Tmux [.tmux.conf](https://github.com/wangsongiam/dotfiles/blob/master/.tmux.conf)
* Zsh [.zshrc](https://github.com/wangsongiam/dotfiles/blob/master/zshrc/.zshrc)

## Sidenote 
Due to heavy python sever running on the background, you might consider setting up
a unique python virtual environment for Neovim, check [pyenv](https://github.com/zchee/deoplete-jedi/wiki/Setting-up-Python-for-Neovim)

## Todos
- [x] ~~Use Neomake for asynchronous linting~~
- [x] Demos
- [x] A.L.E for linting
- [x] ~~Use Deoplete for asynchronous completion~~
- [x] cmd key shortcuts for tmux
- [ ] diminactive
- [ ] clean comments
- [ ] install.sh for quick installation
- [x] Linux setup
