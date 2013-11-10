all: install set_paths

install:
	ln -sfn `pwd`/Sublime\ Text\ 2 ~/Library/Application\ Support/Sublime\ Text\ 2
	ln -sfn `pwd`/gitconfig ~/.gitconfig
	ln -sfn `pwd`/zshrc ~/.zshrc
	ln -sfn `pwd`/zshenv ~/.zshenv
	ln -sfn `pwd`/ruby-version ~/.ruby-version

set_paths:
	sudo sh -c 'echo /usr/local/bin > /etc/paths.d/brew'
