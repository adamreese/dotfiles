DOTFILES := $(shell pwd)
all: shell tmux _ruby _vim _git _postgres
shell:
	ln -fs $(DOTFILES)/bashrc ${HOME}/.bashrc
	ln -fs $(DOTFILES)/bashenv ${HOME}/.bashenv
	ln -fs $(DOTFILES)/bashrc ${HOME}/.bashrc
	ln -fs $(DOTFILES)/bash_profile ${HOME}/.bash_profile
	ln -fs $(DOTFILES)/bash_prompt ${HOME}/.bash_prompt
	ln -fs $(DOTFILES)/zshrc ${HOME}/.zshrc
	ln -fs $(DOTFILES)/zshenv ${HOME}/.zshenv
	ln -fs $(DOTFILES)/zlogin ${HOME}/.zlogin
	ln -fs $(DOTFILES)/zlogout ${HOME}/.zlogout
	ln -fs $(DOTFILES)/ackrc ${HOME}/.ackrc
	ln -fs $(DOTFILES)/agignore ${HOME}/.agignore
	ln -fs $(DOTFILES)/ctags ${HOME}/.ctags
	ln -fs ${DOTFILES}/aliases ${HOME}/.aliases
	ln -fs ${DOTFILES}/agignore ${HOME}/.agignore
	# ln -fns ${DOTFILES}/zsh ${HOME}/.zsh
tmux:
	ln -fs $(DOTFILES)/tmux.conf ${HOME}/.tmux.conf
_vim:
	ln -fns $(DOTFILES)/vim ${HOME}/.vim
	ln -fns $(DOTFILES)/vim ${HOME}/.config/nvim
	ln -fs $(DOTFILES)/gvimrc ${HOME}/.gvimrc
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
_ruby:
	ln -fs $(DOTFILES)/irbrc ${HOME}/.irbrc
	ln -fs $(DOTFILES)/pryrc ${HOME}/.pryrc
	ln -fs ${DOTFILES}/gemrc ${HOME}/.gemrc
	ln -fs ${DOTFILES}/rspec ${HOME}/.rspec
_git:
	ln -fns $(DOTFILES)/git ${HOME}/.config/git
_postgres:
	ln -fs $(DOTFILES)/psqlrc ${HOME}/.psqlrc
_sqlite:
	ln -fs $(DOTFILES)/sqliterc ${HOME}/.sqliterc
_osx:
	ln -fs $(DOTFILES)/slate ${HOME}/.slate
