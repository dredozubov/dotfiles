export WORDCHARS='*?_[]~=&;!#$%^(){}'

autoload -U compinit promptinit
compinit
promptinit

autoload colors; colors

zmodload zsh/complist
#zmodload zsh/files
#zmodload zsh/pcre

export PYTHONPATH=$PYTHONPATH:~/trunk/django
export PYTHONPATH=$PYTHONPATH:/usr/lib/python2.6/site-packages/
export PATH=$PATH:/sbin
export JAVA_HOME=/usr
export PATH=~/depot_tools:"$PATH"
export EC2_HOME=~/ec2-api-tools-1.3-51254/
export EC2_PRIVATE_KEY=~/.ec2/pk-65BZDAH6S66LSI4XSEISOMGKOEE2WD62.pem
export EC2_CERT=~/.ec2/cert-65BZDAH6S66LSI4XSEISOMGKOEE2WD62.pem 
export no_proxy="localhost,*.loc,127.0.0.0/8,192.168.0.0/16"
export EDITOR="vim"

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
alias g="git status"
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
alias g='git status'
alias gg='git grep'


alias ls='ls -aG'
alias less='less -R'
#}}}

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

function setdsm() { 
    # add the current directory and the parent directory to PYTHONPATH
    # sets DJANGO_SETTINGS_MODULE
    export PYTHONPATH=$PYTHONPATH:$PWD/..
    export PYTHONPATH=$PYTHONPATH:$PWD
    if [ -z "$1" ]; then 
        x=${PWD/\/[^\/]*\/}               
        export DJANGO_SETTINGS_MODULE=$x.settings
    else    
        export DJANGO_SETTINGS_MODULE=$1 
    fi

    echo "DJANGO_SETTINGS_MODULE set to $DJANGO_SETTINGS_MODULE"
}

# rvm
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function
export PATH=/opt/local/bin:/opt/local/sbin:$PATH

#virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/workspace
source /usr/local/bin/virtualenvwrapper.sh

# workon alias
#alias workon $arg = workon & cd $PROJECT_HOME/$arg
em () { workon $1 & cd $PROJECT_HOME/$1 }

# rvm 
if [ -f $HOME/.rvm/scripts/rvm ]
then
  source $HOME/.rvm/scripts/rvm
fi

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH:/usr/local/sbin"

# ctags and other brewed software
export PATH="/usr/local/bin:$PATH"

# git ^ fix
setopt NO_NOMATCH
