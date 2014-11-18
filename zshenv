# PATH additions

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH:/usr/local/sbin"
# chrome/chromium tools
#export PATH=~/depot_tools:"$PATH"
# rvm
#export PATH=/opt/local/bin:/opt/local/sbin:$PATH:$HOME/.rvm/bin

export JAVA_HOME=/usr
export EDITOR="vim"

# rvm
#[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function
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
# first part of command checks brew availability
[[ -s "/usr/local/bin/brew" ]] && export RUBY_CONFIGURE_OPTS=--with-readline-dir=`brew --prefix readline`

# git ^ fix
setopt NO_NOMATCH

# add cabal to PATH
PATH=$HOME/.cabal/bin:$PATH

# ghc arcanist
export PATH="$HOME/workspace/arcanist/bin:$PATH"
