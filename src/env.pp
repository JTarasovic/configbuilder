# !file

export EDITOR=vim

!ifdef (dircolors) (
!sh
```
dircolors !cwd/dir_colors
```
export USER_LS_COLORS="$LS_COLORS"
)(# dircolors export omitted)

!ifdef (bat) (
export BAT_THEME="Nord"
)(# bat export omitted)

!ifdef (nvim) (
export EDITOR=nvim
)(# nvim export omitted)


# computed PATH based on fs layout
!sh
```
# TODO: figure out /{,s}bin, /usr/{,s}bin, etc

PATH="/usr/sbin:/usr/bin"
pathmunge () {
    # exit early if dir doesn't exist
    [ ! -d "$1" ] && return
    # if path isn't already in $PATH
    if ! echo "$PATH" | grep -Eq "(^|:)$1($|:)" ; then
         PATH=$1:$PATH
    fi
}

pathmunge /usr/local/bin
pathmunge /usr/local/sbin
pathmunge /usr/local/go/bin
pathmunge /usr/local/heroku/bin
pathmunge "$HOME/.local/bin"
pathmunge "$HOME/.rvm/bin"
pathmunge "$HOME/mongo/current/bin"
pathmunge "$HOME/Library/Python/3.7/bin"
pathmunge "${KREW_ROOT:-$HOME/.krew}/bin"
pathmunge "$HOME/.cargo/bin"
pathmunge "$HOME/go/bin"

echo "export PATH=$PATH"
```
