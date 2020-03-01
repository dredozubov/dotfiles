## enable it to profile the zsh init
# zmodload zsh/zprof

# brew and other Stuff
# i hate it, but it must be included in zshrc, not zshenv
export PATH="/usr/local/bin:$PATH"
# cabal
export PATH="$HOME/.cabal/bin:$HOME/Library/Haskell/bin:$PATH"
# stack
export PATH="$HOME/.local/bin:$PATH"

# bash completion
if [ -f `brew --prefix`/etc/bash_completion ]; then
     . `brew --prefix`/etc/bash_completion
fi

# python miniconda
# source /Users/dr/miniconda3/bin/activate

autoload -U compinit promptinit
compinit
promptinit

autoload colors; colors

zmodload zsh/complist
#zmodload zsh/files
#zmodload zsh/pcre

export HISTSIZE=200
export HISTFILE=~/.zsh_history
export SAVEHIST=200

setopt BASH_AUTO_LIST
setopt hist_ignore_all_dups
setopt extendedglob

setopt bad_pattern
setopt brace_ccl

setopt append_history
setopt inc_append_history

zle_highlight=(isearch:bg=red region:standout special:standout)

#{{{ ALIASES
# Utility
alias reload='source ~/.zshrc'
alias updatedb='sudo /usr/libexec/locate.updatedb'
alias xmlpp='xmllint --format -'

# os x - finder
alias o="open . &"

# Quicker cd
function cr() {
 cd ~/workspace/$*
}

# top
alias tu="top -o cpu"
alias tm="top -o vsize"

# kill
alias k9="killall -9"
function killnamed () {
    ps ax | grep $1 | cut -d ' ' -f 2 | xargs kill
}

# git
alias g="git status -uno"
alias gu="git status"
alias ga="git add"
alias gb="git branch"
alias gba="git branch -a"
alias gc="git commit -v"
alias gcm="git commit -v -m"
alias gco='git checkout'
alias gd='git diff --color'
alias gdm='git diff --color master'
alias gl='git pull'
alias gnp="git-notpushed"
alias gp='git push'
alias gst='git status'
alias gt='git status'
alias gg='git grep'

# grep
alias grep='grep --color'
alias zgrep='zgrep --color'
alias egrep='egrep --color'
alias fgrep='fgrep --color'

# bundler
alias b="bundle exec"
alias bi="bundle install"


alias ls='ls -aG'
alias less='less -R'

#{{{ Completion Stuff
_force_rehash() {
  (( CURRENT == 1 )) && rehash
  return 1  # Because we didn't really complete anything
}

bindkey -M viins '\C-i' complete-word

# Makes things faster
zstyle ':completion::complete:*' use-cache 1
# case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' completer _expand _force_rehash _complete _approximate _ignored
# generate descriptions with magic.
zstyle ':completion:*' auto-description 'specify: %d'
# Don't prompt for a huge list, page it!
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
# Don't prompt for a huge list, menu it!
zstyle ':completion:*:default' menu 'select=0'
# Have the newer files last so I see them first
zstyle ':completion:*' file-sort modification reverse
# color code completion!!!!  Wohoo!
zstyle ':completion:*' list-colors "=(#b) #([0-9]#)*=36=31"
unsetopt LIST_AMBIGUOUS
setopt  COMPLETE_IN_WORD
# Separate man page sections.  Neat.
zstyle ':completion:*:manuals' separate-sections true
# Egomaniac!
zstyle ':completion:*' list-separator 'fREW'
# complete with a menu for xwindow ids
zstyle ':completion:*:windows' menu on=0
zstyle ':completion:*:expand:*' tag-order all-expansions
# more errors allowed for large words and fewer for small words
zstyle ':completion:*:approximate:*' max-errors 'reply=(  $((  ($#PREFIX+$#SUFFIX)/3  ))  )'
# Errors format
zstyle ':completion:*:corrections' format '%B%d (errors %e)%b'
# Don't complete stuff already on the line
zstyle ':completion::*:(rm|vi):*' ignore-line true
# Don't complete directory we are already in (../here)
zstyle ':completion:*' ignore-parents parent pwd
zstyle ':completion::approximate*:*' prefix-needed false

#}}}

#{{{ PROMPT
local blue_op="%{$fg[blue]%}[%{$reset_color%}"
local blue_cp="%{$fg[blue]%}]%{$reset_color%}"
local red_op="%{$fg_bold[red]%}[%{$reset_color%}"
local red_cp="%{$fg_bold[red]%}]%{$reset_color%}"
local path_p="${blue_op}%~${blue_cp}"
local user_host="%{$fg_bold[green]%}%n@%m%{$reset_color%}"
local root_host="%{$fg[red]%}%n@%m%{$reset_color%}"
local date_time="${blue_op}%* %D${blue_cp}${reset_color}"
local ret_status="${blue_op}%?${blue_cp}"
local hist_no="${blue_op}%h${blue_cp}"
local smiley="%(?,%{$fg[green]%}:%)%{$reset_color%},%{$fg[red]%}:(%{$reset_color%})"
local jsmiley="%(?,%{$fg[green]%}(づ｡◕‿‿◕｡)づ%{$reset_color%},%{$fg[red]%}(╯°□°%)╯︵┻━┻)${reset_color} "

setopt prompt_subst
local cur_cmd="${blue_op}%_${blue_cp}"
PROMPT="%(!.${root_host}.${user_host})-${ret_status}-${date_time}
${blue_op}${smiley}${blue_cp} ${path_p} %# "
PROMPT2="${cur_cmd}> "

#RPROMPT="\$(cabal_sandbox_info) $RPROMPT"
#}}}

#{{{ BINDINGS
bindkey -e
alias vims='vim --remote-silent'
## linux bindings
#bindkey '^[[1~' beginning-of-line
#bindkey '^[[4~' end-of-line
#bindkey '^[OH' beginning-of-line
#bindkey '^[OF' end-of-line
#bindkey '^[[1;5D' backward-word
#bindkey '^[[1;5C' forward-word
#bindkey '^R' history-incremental-search-backward
#bindkey '^Y' history-incremental-search-forward
#bindkey '^[[3~' delete-char
#alias gvims="gvim --remote-silent"

# os x bindings
alias gvims="mvim --remote-silent"
#}}}

# workon alias
#alias workon $arg = workon & cd $PROJECT_HOME/$arg
em () { workon $1 & cd $PROJECT_HOME/$1 }

# OPAM configuration
. /Users/dr/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# ssh-tmux helper
function ssht () {/usr/bin/ssh -t $@ "tmux attach || tmux new";}

PERL_MB_OPT="--install_base \"/Users/dr/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/dr/perl5"; export PERL_MM_OPT;

# fix iterm2 and os x ssh/locale issues
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

source ~/.secret_env

# added by travis gem
[ -f /Users/dr/.travis/travis.sh ] && source /Users/dr/.travis/travis.sh

# gopath
export GOPATH="$HOME/golang/"

# ansible
export ANSIBLE_NOCOWS=1

ssh-add ~/.ssh/id_rsa
ssh-add ~/.ssh/gitlab

alias notify-done='terminal-notifier -title "Terminal" -message "Done with task!"'

# homebrew openssl
export LDFLAGS=-L/usr/local/opt/openssl/lib
export CPPFLAGS=-I/usr/local/opt/openssl/include
export PKG_CONFIG_PATH=/usr/local/opt/openssl/lib/pkgconfig

# homebrew libicu
export LDFLAGS="-L/usr/local/opt/icu4c/lib $LDFLAGS"
export CPPFLAGS="-I/usr/local/opt/icu4c/include $CPPFLAGS"

# hasktags
# alias mkhasktags='hasktags --ignore-close-implementation --etags .; sort tags'

# ignores intero directories and other artifacts
alias mkhasktags='hasktags --ignore-close-implementation --etags $(find `pwd` -iname '*.hs' -and \( -not -path '*.stack-work*' \) -and \( -not -name 'Setup.hs' \) -and -type f) .'
alias mkhasktags-tinkoff='hasktags --ignore-close-implementation --etags -S.hs platform/ tinkoff-travel'
alias mkhasktags-b2b='hasktags --ignore-close-implementation --etags -S.hs b2b/ platform/'
alias mkhasktags-travel246='hasktags --ignore-close-implementation --etags -S.hs travel246/ platform/'
alias mkhasktags-atcshopper='hasktags --ignore-close-implementation --etags -S.hs atcshopper/ platform/'
alias mkhasktags-genfly='hasktags --ignore-close-implementatino --etags -S.hs genfly/ platform/'
alias mkhasktags-ad='hasktags --ignore-close-implementation --etags -S.hs .'

# swap two files/directories
function swap()
{
    local TMPFILE=tmp.$$
    mv "$1" $TMPFILE
    mv "$2" "$1"
    mv $TMPFILE "$2"
}

export PATH="$HOME/.cargo/bin:$PATH"
alias cabla='cabal'

export PATH=/Users/dr/.local/bin/luna-studio:$PATH

# google-cloud-sdk completers
# source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
# source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'

if which jenv > /dev/null; then eval "$(jenv init -)"; fi
export PATH="$HOME/.jenv/shims:$PATH"

alias ec='emacsclient -n -a ""'
alias syscalls='man -k . | grep "(2)"'

export PATH="/usr/local/opt/postgresql@10/bin:$PATH"
export PATH="/usr/local/opt/postgresql@10/bin:$PATH"

# direnv
eval "$(direnv hook zsh)"

# os x postgres
export PGHOST=/tmp

# nix-remote-build b2b
# alias nix-build-remote='nix-build '"'"'(with import <nixpkgs> { system = "x86_64-darwin"; }; runCommand "" {} "uname > $out")' \ --show-trace --builders 'ssh-ng://b2builder'"'"

# initialize nix 2
. /Users/dr/.nix-profile/etc/profile.d/nix.sh

# make overlays globally visible
#export NIX_PATH=$NIX_PATH:/Users/dr/.config/nixpkgs/overlays

# unset it after https://github.com/NixOS/nixpkgs/pull/73744 gets merged
# generate by running 'make zhsrc' in nix-config
export NIX_PATH="nixpkgs=/Users/dr/workspace/nix-config/nixpkgs"

# kubernetes
source <(kubectl completion zsh)  # setup autocomplete in zsh into the current shell
echo "if [ $commands[kubectl] ]; then source <(kubectl completion zsh); fi" >> ~/.zshrc # add autocomplete permanently to your zsh shell
