# bash completion
autoload bashcompinit
bashcompinit

# brew and other Stuff
# i hate it, but it must be included in zshrc, not zshenv
export PATH="/usr/local/bin:$PATH"

# virtualenvwrapper
# it uses script from /usr/local/bin, so it's here
export WORKON_HOME=$HOME/.venv
if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
    source /usr/local/bin/virtualenvwrapper.sh
fi
 
# bash completion
if [ -f `brew --prefix`/etc/bash_completion ]; then
     . `brew --prefix`/etc/bash_completion
fi

# default python virtualenv
if [ -f "$HOME/.venv/py27/bin/activate" ]; then
    source $HOME/.venv/py27/bin/activate
fi

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

# workon alias
#alias workon $arg = workon & cd $PROJECT_HOME/$arg
em () { workon $1 & cd $PROJECT_HOME/$1 }

