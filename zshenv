export PATH=$PATH:/sbin
export JAVA_HOME=/usr
export PATH=~/depot_tools:"$PATH"
export EC2_HOME=~/ec2-api-tools-1.3-51254/
export EC2_PRIVATE_KEY=~/.ec2/pk-65BZDAH6S66LSI4XSEISOMGKOEE2WD62.pem
export EC2_CERT=~/.ec2/cert-65BZDAH6S66LSI4XSEISOMGKOEE2WD62.pem 
export no_proxy="localhost,*.loc,127.0.0.0/8,192.168.0.0/16"
export EDITOR="vim"

#virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/workspace
source /usr/local/bin/virtualenvwrapper.sh

# rvm 
#PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
#[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function
#export PATH=/opt/local/bin:/opt/local/sbin:$PATH

#if [ -f $HOME/.rvm/scripts/rvm ]
#then
  #source $HOME/.rvm/scripts/rvm
#fi

# chruby
[ -n "$BASH_VERSION" ] || [ -n "$ZSH_VERSION" ] || return
source /usr/local/opt/chruby/share/chruby/chruby.sh
source /usr/local/opt/chruby/share/chruby/auto.sh

# ruby-build
# read with readline by default, depends on brew
export RUBY_CONFIGURE_OPTS=--with-readline-dir=`brew --prefix readline`

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH:/usr/local/sbin"

# ctags and other brewed software
export PATH="/usr/local/bin:$PATH"

# git ^ fix
setopt NO_NOMATCH
