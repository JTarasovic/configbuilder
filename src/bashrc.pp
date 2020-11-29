!import (macros.pp)!header

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Don't check mail when opening terminal.
unset MAILCHECK

!include (env.pp)
!include (aliases.pp)
!include (functions.pp)

!ifdef (starship) (eval $(starship init bash)) (# starship init omitted)

return 0
