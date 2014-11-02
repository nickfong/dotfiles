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
export GIT_EDITOR=vim
export GIT_VISUAL=vim

# No need to type cd
shopt -s autocd
    
# Set custom navigation/display
alias ls='ls -GlhpF'
alias ll='ls -GalhpF'
alias l='ls -GlhpF'
alias ..='cd ..'

# Set colors for ls and grep
export CLICOLOR=1
export LSCOLORS=ExGxBxDxCxEgEdxbxgxcxd
export GREP_OPTIONS='--color=auto'

# Custom Git Commands
alias gitpush='git push github master'
alias gitpull='git pull github master'
alias gitcom='git commit'
alias gitadd='git add -u'

# Timesavers
alias reload='source ~/.bash_profile'
alias rmspaces='find . -depth | rename " " "_" *'

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

# Custom prompt
export PS1="\["$SYSCOLOR"\][\u@\[\e[0;31m\]\h\[\e[m\] \[\e[m\]\[\e[0;94m\]\W\[\e[m\]\["$SYSCOLOR"\]][\d \t]\["$SYSCOLOR"\]\[\e[m\]\$(if [[ \$? == 0 ]]; then echo \"\[\033[01;32m\]\$\"; else echo \"\[\033[01;31m\]\$\"; fi) \[\033[01;37m\]"
export PS2="[\d \t] continue> "
## end .bash_profile ##

