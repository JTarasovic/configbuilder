!import (macros.pp)!header

# set history options
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.histfile
bindkey -v

# man 1 zshoptions
setopt incappendhistory histignorealldups sharehistory extendedhistory
setopt autocd extendedglob correct autopushd
setopt notify

unsetopt nomatch

autoload -Uz promptinit
promptinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _extensions _ignored _approximate
zstyle ':completion:*' max-errors 2
zstyle ':completion:*' menu select
zstyle ':completion:*' verbose true
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

zstyle ':completion:*:kill:*' command 'ps -u $USER -o command,pid,%cpu,tty,cputime,cmd'
autoload -Uz compinit
compinit

!include (aliases.pp)
!include (functions.pp)

!rawinclude (zsh-prompt-benchmark.zsh)

!ifdef (starship) (eval $(starship init zsh)) (# starship init omitted)

!ifdef (zsh_syntax_highlighting)(
source !zsh_syntax_highlighting
)(# zsh-syntax-highlighting omitted)

# if we make it this far return cleanly /shrug
return 0
