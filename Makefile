DOTFILES := $(shell pwd)
all: shell tmux _ruby _vim _git _postgres
shell:
	ln -fs $(DOTFILES)/bashrc ${HOME}/.bashrc
	ln -fs $(DOTFILES)/bashenv ${HOME}/.bashenv
	ln -fs $(DOTFILES)/bashrc ${HOME}/.bashrc
	ln -fs $(DOTFILES)/profile ${HOME}/.bash_profile
	ln -fs $(DOTFILES)/profile ${HOME}/.zprofile
	ln -fs $(DOTFILES)/zshrc ${HOME}/.zshrc
	ln -fs $(DOTFILES)/zlogout ${HOME}/.zlogout
	ln -fs $(DOTFILES)/zshenv ${HOME}/.zshenv
	ln -fs $(DOTFILES)/ackrc ${HOME}/.ackrc
	ln -fs $(DOTFILES)/ctags ${HOME}/.ctags
	ln -fs ${DOTFILES}/aliases ${HOME}/.aliases
	ln -fs ${DOTFILES}/zsh ${HOME}/.zsh
tmux:
	ln -fs $(DOTFILES)/tmux.conf ${HOME}/.tmux.conf
_vim:
	ln -fns $(DOTFILES)/vim ${HOME}/.vim
	ln -fs $(DOTFILES)/vimrc ${HOME}/.vimrc
	ln -fs $(DOTFILES)/gvimrc ${HOME}/.gvimrc
_ruby:
	ln -fs $(DOTFILES)/irbrc ${HOME}/.irbrc
	ln -fs $(DOTFILES)/pryrc ${HOME}/.pryrc
	ln -fs $(DOTFILES)/rdebugrc ${HOME}/.rdebugrc
	ln -fs ${DOTFILES}/gemrc ${HOME}/.gemrc
	ln -fs ${DOTFILES}/rspec ${HOME}/.rspec
_git:
	ln -fs $(DOTFILES)/gitconfig ${HOME}/.gitconfig
	ln -fs $(DOTFILES)/gitignore ${HOME}/.gitignore
	ln -fns $(DOTFILES)/git_template ${HOME}/.git_template
_postgres:
	ln -fs $(DOTFILES)/psqlrc ${HOME}/.psqlrc
_sqlite:
	ln -fs $(DOTFILES)/sqliterc ${HOME}/.sqliterc
_osx:
	ln -fs $(DOTFILES)/slate ${HOME}/.slate
