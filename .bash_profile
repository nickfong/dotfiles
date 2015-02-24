## begin .bash_profile ##
export BLACK="\e[90m"
export RED="\e[31m"
export GREEN="\e[92m"
export YELLOW="\e[93m"
export BLUE="\e[94m"
export MAGENTA="\e[95m"
export CYAN="\e[96m"
export WHITE="\e[97m"

export VISUAL=vim
export EDITOR=vim

# No need to type cd
shopt -s autocd

# Set custom navigation/display
alias ls='ls -GlhpF --color=auto'
alias ll='ls -GalhpF'
alias l='ls -GlhpF'
alias ..='cd ..'

# Set colors for ls and grep
export CLICOLOR=1
export LSCOLORS=ExGxBxDxCxEgEdxbxgxcxd
export GREP_OPTIONS='--color=auto'
alias grep="/usr/bin/grep $GREP_OPTIONS"
unset GREP_OPTIONS

# Timesavers
alias s='ssh'
alias g='git'
alias v='vim'
alias reload='source ~/.bash_profile'
alias rmspaces='find . -depth | rename " " "_" *'

# Share screen session
alias csharescreen='screen -dmS sharedscreen'
alias sharescreen='screen -x sharedscreen'

# Green Prompt
SYSCOLOR=$GREEN

if [ -a ~/.bash_profile.personal ]; then
    source ~/.bash_profile.personal
    SYSCOLOR=$CYAN
fi

if [ -a ~/.bash_profile.ocf ]; then
    source ~/.bash_profile.ocf
    SYSCOLOR=$WHITE
fi

if [ -a ~/.bash_profile.nersc ]; then
    source ~/.bash_profile.nersc
    SYSCOLOR=$RED
fi

if [ -a ~/.bash_profile.inst ]; then
    source ~/.bash_profile.inst
    SYSCOLOR=$BLUE
fi

# GNUPG Aliases
alias gpgsign='gpg --sign --clearsign'
alias gpgsignu='gpg --sign --clearsign -u'
alias gpgdecrypt='gpg --decrypt'
alias gpgverify='gpg --verify'
alias gpgencrypt='gpg --armor --encrypt'
alias gpgsym='gpg --armor --symmetric'

# Custom prompt
export PS1="\["$SYSCOLOR"\][\u@\[\e[0;31m\]\h\[\e[m\] \[\e[m\]\[\e[0;94m\]\W\[\e[m\]\["$SYSCOLOR"\]][\d \t]\["$SYSCOLOR"\]\[\e[m\]\$(if [[ \$? == 0 ]]; then echo \"\[\033[01;32m\]\$\"; else echo \"\[\033[01;31m\]\$\"; fi) \[\033[01;37m\]"
export PS2="[\d \t] continue> "

man() {
    env LESS_TERMCAP_mb=$'\E[01;31m' \
    LESS_TERMCAP_md=$'\E[01;38;5;74m' \
    LESS_TERMCAP_me=$'\E[0m' \
    LESS_TERMCAP_se=$'\E[0m' \
    LESS_TERMCAP_so=$'\E[38;5;246m' \
    LESS_TERMCAP_ue=$'\E[0m' \
    LESS_TERMCAP_us=$'\E[04;38;5;146m' \
    man "$@"
}

## end .bash_profile ##

