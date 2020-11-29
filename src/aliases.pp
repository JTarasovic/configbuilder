# !file

# terminal manipulation
alias c='clear'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias flatten='find ./ -type f -exec mv '{}' . \;'
alias yml2yaml='for f in *.yml; do mv -- "$f" "${f%.yml}.yaml"; done'

!ifdef (yum) (
alias update='sudo yum update'
alias install='sudo yum install'
alias search='yum search'
)(# yum aliases omitted)

!ifdef (dnf) (
alias update='sudo dnf update'
alias install='sudo dnf install'
alias search='dnf search'
)(# dnf aliases omitted)

!ifdef (apt) (
alias update='sudo apt-get update && sudo apt-get upgrade'
alias install='sudo apt-get install'
alias search='apt-cache search'
alias add='sudo add-apt-repository'
)(# apt aliases omitted)

!ifdef (pacman) (
alias update='sudo pacman -Syu'
alias install='sudo pacman -S'
alias search='pacman -Ss'
)(# pacman aliases omitted)

# TODO: these can probably be reduced / cleaned up
!ifdef (linux) (
alias l='ls --color=auto'
alias l.='ls -d .* --color=auto'
alias la='ls -lah --color=auto'
alias ll='ls -lh --color=auto'
alias ls='ls --color=auto'
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
)(# linux aliases omitted)

!ifdef (darwin) (
#for *BSD/darwin
export CLICOLOR=1
alias l='ls'
alias l.='ls -d .*'
alias la='ls -lah'
alias ll='ls -lh'
alias dtls='apropos dtrace'
)(# darwin aliases omitted)

!ifdef (brew) (
#brew aliases
alias update='brew update && brew upgrade && brew cask upgrade'
alias install='brew install'
alias search='brew search'
)(# brew aliases omitted)

!ifdef (bat) (
alias cat='bat'
)(# bat aliases omitted)

!ifdef (git) (
# git quick actions
alias gs='git status'
alias gr='git reset --hard @'
alias push='git push'
alias gprp='git pull && git remote prune origin && git gc'
alias config='/usr/bin/git --git-dir=$HOME/.remotecfg/ --work-tree=$HOME'
alias dirty_dirs='for dir in *; do pushd "$dir" > /dev/null; $(git -c diff.autorefreshindex=true diff --quiet) || echo "$dir is dirty"; popd > /dev/null; done'
)(# git aliases omitted)

!ifdef (kubectl) (
# kubectl
alias k='kubectl '
!sh
```
for context in $(kubectl config get-contexts -o name);
do
    clean_ctx="$(echo "$context" | tr -d "-")"
    alias_to_create="$(printf "%s%s" "k" "$clean_ctx")"
    echo alias "$alias_to_create='kubectl --context=$context '"
done
```
)(# kubectl aliases omitted)
