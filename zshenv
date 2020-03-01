# PATH additions

export JAVA_HOME=/usr
export EDITOR="vim"

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
#[[ -s "/usr/local/bin/brew" ]] && export RUBY_CONFIGURE_OPTS=--with-readline-dir=`brew --prefix readline`

# git ^ fix
setopt NO_NOMATCH

# add cabal to PATH
PATH=$HOME/.cabal/bin:$PATH

# ghc arcanist
export PATH="$HOME/workspace/arcanist/bin:$PATH"
