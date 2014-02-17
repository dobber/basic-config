# ~/.bashrc: executed by bash(1) for non-login shells.

umask 022
export PATH=/bin:/usr/bin:/usr/local/bin:/sbin:/usr/sbin:/usr/local/sbin:/usr/bin/X11:/usr/games:/usr/local/exim/bin
export PS1="\[\033[32m\][\u@\h]:\w\\$\[\033[0m\] "
export EDITOR=vim
export PAGER=less

# shortcurts
alias ls='ls -F --color=auto'
alias v='ls -l'
alias d="ls"
alias va='ls -la'
alias ll='ls -la'
alias la='ls -a'
alias lss='ls -1s'
alias t='telnet'
alias n='nslookup'
alias p='ping'
alias tc='/usr/sbin/traceroute'
alias k='killall -9'
alias joe='joe -nobackups -lightoff -marking -asis'
alias jo='joe'
alias les='less'
alias c="clear"
alias inject="eject -t"
alias dfh="df -h | head"
alias grpe="grep"
alias dmesg="dmesg -T"

# extras
alias tt="awk '{if (\$1 && \$1 !~ /#/) print}'"

# git stuff
alias gl="git log --graph --decorate --pretty=oneline --abbrev-commit --all"
alias gss="git status"
git config --global alias.undo-commit 'reset --soft HEAD^'
