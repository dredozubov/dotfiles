export JAVA_HOME=/usr
# chrome/chromium tools
#export PATH=~/depot_tools:"$PATH"
export no_proxy="localhost,*.loc,127.0.0.0/8,192.168.0.0/16"
export EDITOR="vim"

# needed for ruby brew helper below
export PATH=/usr/local/bin:$PATH

# rvm 
#PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
#[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function
#export PATH=/opt/local/bin:/opt/local/sbin:$PATH

#if [ -f $HOME/.rvm/scripts/rvm ]
#then
  #source $HOME/.rvm/scripts/rvm
#fi

# chruby
if [[ -e /usr/local/share/chruby ]]; then
  # Load chruby
  source '/usr/local/share/chruby/chruby.sh'

  # Automatically switch rubies
  source '/usr/local/share/chruby/auto.sh'

  # Set a default ruby if a .ruby-version file exists in the home dir
  if [[ -f ~/.ruby-version ]]; then
    chruby $(cat ~/.ruby-version)
  fi
fi

# ruby-build
# read with readline by default, depends on brew
export RUBY_CONFIGURE_OPTS=--with-readline-dir=`brew --prefix readline`

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH:/usr/local/sbin"

# ctags and other brewed software
export PATH="/usr/local/bin:$PATH"

# git ^ fix
setopt NO_NOMATCH

#virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/workspace
source /usr/local/bin/virtualenvwrapper.sh

