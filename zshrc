#
## Preamble
#

# If this is a TTY, then we may be in rescue mode. Therefore, launch bash for speed, and exit with it
if ( [ $TERM = "linux" ] ); then
	/bin/bash --login
	exit
fi

## If we're not inside of a tmux instance, start one
if [ "$TMUX" = "" ]; then
    tmux
    exit
fi

#
## User-defined functions
#

# add push notifications over Pushover
push() {
  curl -s -F "token=afgq15q22847cg8e1xjpmjfug5ran3" -F "user=u2f4smknjr4z5mhc3xque2jzp7ap7n" -F "title=Work Blackbox" -F "message=$1" https://api.pushover.net/1/messages.json
}

open() {
  zsh -c "
    mimeo \"$1\" &
    disown mimeo
  "
}

# print some wisdom by our favorite animals
cowspeakfortune() {
  h=`date +%H`
  # If early morning (middle of the night)
  if [ $h -lt 06 ]
  then
      cowargs="elephant"
  # If mid to late morning
  elif [ $h -lt 12 ]
  then
      cowargs="moose"
  # If early afternoon
  elif [ $h -lt 16 ]
  then
      cowargs="tux"
  # If mid morning
  elif [ $h -lt 20 ]
  then
      cowargs="vader"
  # If late night
  elif [ $h -lt 24 ]
  then
      cowargs="dragon-and-cow"
  # If we missed a case
  else
      cowargs="-d"
  fi
  # Now print motd
  echo $fg[cyan]
  fortune -s | cowsay -f $cowargs
  echo ""
}

ssh_clean() {
    sed -i "/$1/,+1 d" ~/.ssh/known_hosts
}

#
## Oh-My-Zsh Configuration
#

# path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# set name of the theme to load.
ZSH_THEME="gallois"

# uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# uncomment the following line to enable command auto-correction.
#ENABLE_CORRECTION="true"

# uncomment the following line to display red dots whilst waiting for completion.
#COMPLETION_WAITING_DOTS="true"

# uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# the optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# increase History Length
HISTSIZE=999999999
SAVEHIST=$HISTSIZE

# which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git sudo ssh-agent history wd zsh_reload)


# source oh-my-zsh setup
source $ZSH/oh-my-zsh.sh

#
## User configuration
#

# Enable bash completion (for virtex)
#autoload -U compinit && compinit
# Only reload compinit database once per day
autoload -U bashcompinit && bashcompinit
source /etc/bash_completion.d/virtex
# Define bash-only completion functions as filler stubs
compopt() { :; }
_get_comp_words_by_ref() { :; }
__ltrim_colon_completions() { :; }

# Don't throw an error when a glob doesn't match anything.
setopt nonomatch

# Get all the UTF
export LANG=en_US.utf-8
export LC_ALL=en_US.utf-8

export PATH="$HOME/.bin:$HOME/.local/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/ida-6.95:$PATH"

# Android Tools PATH
export PATH="$PATH:/home/will/Android/Sdk/tools:/home/will/Android/Sdk/platform-tools"

# Ruby Gems
export PATH="$PATH:$HOME/.gem/ruby/2.4.0/bin"

# Add cross-compilation tools for ARM
export PATH="$PATH:/usr/local/bin/cross"

# Add virtex dev path
export PATH="$PATH:$HOME/Documents/Virtex-VM/bin"

# Go workspace path
export GOPATH="$HOME/Documents/golang"

# Add Go bin to path
export PATH="$PATH:$GOPATH/bin"

# Add Qt Libs to lib path - This breaks IDA Pro 7.0
#export LD_LIBRARY_PATH=/opt/Qt/5.9/gcc_64/lib:$LD_LIBRARY_PATH

# Add CMAKE_PREFIX_PATH for Qt compatability
export CMAKE_PREFIX_PATH=/opt/Qt/5.9/gcc_64

# Set fake "window manager" to make IDA inherit gtk+2 theme
export XDG_CURRENT_DESKTOP=gnome

# Import gitlab ssh key
ssh-add ~/.ssh/keys/gitlab 2> /dev/null

# make sure we're always editing in vim #vimmasterrace
export EDITOR='nvim'

# why not view our manpages in nvim?
export MANPAGER="nvim -c 'set ft=man' -"

# alias common commands
alias dusort="du -sh * | sort -h"
alias utime="date +%s"
alias ipecho="curl ipecho.net/plain"
alias grep="grep --color=auto"
alias watch="watch -n1"
alias ls="ls --color -l"
alias diff="colordiff"
alias ffprobe="ffprobe -hide_banner"
alias ffmpeg="ffmpeg -hide_banner"
alias sed="sed -E"

alias music="ncmpcpp"
# Linux-specific keyboard speed command
alias fast="/usr/bin/xset r rate 200 40"

# use trash-cli instead of just blasting away files
alias rm=trash
alias trash-size="du -sh /home/will/.local/share/Trash | awk '{print \"Trash Size:\", \$1}'"
alias trash-own="sudo chown -R will:will $HOME/.local/share/Trash/files && sudo chmod 744 -R $HOME/.local/share/Trash/files"

# alias view to read-only vim instead of ex
alias view="vim -R"
alias l="less"

# Automatically give password to weechat
alias weechat="WEECHAT_PASSPHRASE=`cat $HOME/.weechat/secret_pass2.txt` weechat"

# Dircolors
eval `dircolors -b $HOME/.dir_colors`
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# Zsh Syntax Highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Zsh Autocompletion
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# If encrypted Gitlab API token exists, source its contents
if [ -f $HOME/.gitlab.gpg ]; then
    source <(gpg --quiet --decrypt $HOME/.gitlab.gpg)
fi


#
## finalizer
#

# print fortune each time a zsh shell is opened (if the necessary programs are installed)
if hash fortune 2>/dev/null && hash cowsay 2>/dev/null; then
    cowspeakfortune
else
    echo "You do not have fortune or cowspeak installed, sorry"
fi
