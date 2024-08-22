#
## Preamble
#

# If this is a TTY, then we may be in rescue mode. Therefore, launch bash for speed, and exit with it
if ( [ $TERM = "linux" ] ); then
	/bin/bash --login
	exit
fi

#
## User-defined functions
#

open() {
  zsh -c "
    xdg-open \"$1\" &
    disown xdg-open
  "
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

# which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git gpg-agent sudo history wd)

# source oh-my-zsh setup
source $ZSH/oh-my-zsh.sh

# increase History Length
HISTSIZE=999999999
SAVEHIST=$HISTSIZE

#
## User configuration
#

# Don't throw an error when a glob doesn't match anything.
setopt nonomatch

# Get all the UTF
export LANG=en_US.utf-8
export LC_ALL=en_US.utf-8

# Set fake "window manager" to make IDA inherit gtk+2 theme
export XDG_CURRENT_DESKTOP=gnome

# make sure we're always editing in vim #vimmasterrace
export EDITOR='nvim'

# why not view our manpages in nvim?
export MANPAGER="nvim -c 'Man!' -"

# alias common commands
alias grep="grep --color=auto"
alias ip="ip --color"
alias watch="watch -n1"
alias ls="ls --color -lh"
alias ip="ip -color=auto"

# Linux-specific keyboard speed command
alias fast="/usr/bin/xset r rate 200 40"

export GOPATH="$HOME/.local/share/go"

# Add user-pip3 and golang installed packages to PATH
export PATH="$PATH:$HOME/.local/bin:$GOPATH/bin"


# Coloring
eval `dircolors -b $HOME/.dir_colors`
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# Use system fzf if available
DEBIAN_FZF_ZSH=/usr/share/doc/fzf/examples/key-bindings.zsh
[ -f "$DEBIAN_FZF_ZSH" ] && source "$DEBIAN_FZF_ZSH"

FEDORA_FZF_ZSH=/usr/share/fzf/shell/key-bindings.zsh
[ -f "$FEDORA_FZF_ZSH" ] && source "$FEDORA_FZF_ZSH"

# Use Syntax Highlighting if available
ZSH_SYNTAX_HIGHLIGHTING=/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -f "$ZSH_SYNTAX_HIGHLIGHTING" ] && source "$ZSH_SYNTAX_HIGHLIGHTING"

if [[ -e /etc/grc.zsh ]]; then
    source /etc/grc.zsh
    source /etc/profile.d/grc.sh # This should be done automatically, but on
                                 # Fedora with ZSH the file is not always sourced
fi

#
## tweaks/hacks
#

# This is needed for some systems where oh-my-zsh thinks that bzr is available,
# which causes navigation in git repos to be unbelievable slow
alias bzr=true

# Some applications (like tmux) will reset this before launching zsh and that
# errant TERM value will cause programs to misbehave (because they think we're
# running a terminal from 1982). This 'export' should fix us back up in that case.
export TERM=xterm-256color
