all: install

install:
	ln -sfn `pwd`/Sublime\ Text\ 2 ~/Library/Application\ Support/Sublime\ Text\ 2
	ln -sfn `pwd`/gitconfig ~/.gitconfig
	ln -sfn `pwd`/zshrc ~/.zshrc
	ln -sfn `pwd`/zshenv ~/.zshenv
	ln -sfn `pwd`/ruby-version ~/.ruby-version
	ln -sfn `pwd`/ghci ~/.ghci
