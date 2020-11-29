#!/bin/sh

deps=""

# if command exists
for dep in zsh git bash zsh aws bat kubectl dnf yum brew apt pacman nvim starship dircolors;
do
    command -v "$dep" > /dev/null 2>&1 && deps="$deps $dep"
done

# find zsh-syntax-highlighting
zsythi=$(find /usr -type f -name zsh-syntax-highlighting.zsh -readable 2>/dev/null | head -1)
[ -z "$zsythi" ] || deps="$deps zsh_syntax_highlighting=$zsythi"

echo "$deps"
