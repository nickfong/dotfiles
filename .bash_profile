## begin .bash_profile ##
export VISUAL=vim
export EDITOR=vim

# No need to type cd
shopt -s autocd

export HISTTIMEFORMAT='%F %T '  # Show timestamps with histoyr
export HISTCONTROL=ignorespace  # Prepend command w/space to omit from history

# Set custom navigation/display
alias ls='ls -GlhpF --color=auto'
alias ll='ls -GalhpF'
alias l='ls -GlhpF'

# Set colors for grep
export GREP_OPTIONS='--color=auto'
alias grep="$(which grep) $GREP_OPTIONS"
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

# GNUPG Aliases
alias gpgsign='gpg --sign --clearsign'
alias gpgsignu='gpg --sign --clearsign -u'
alias gpgdecrypt='gpg --decrypt'
alias gpgverify='gpg --verify'
alias gpgencrypt='gpg --armor --encrypt'
alias gpgsym='gpg --armor --symmetric'

# Set colors if available
if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # Set colors for ls
    DEFAULT=0
    BOLD=1
    UNDERLINE=4
    FLASHING=5
    REVERSE=7

    RED=31
    GREEN=32
    ORANGE=33
    BLUE=34
    PURPLE=35
    CYAN=36
    GREY=37
    DARK_GREY=90
    LIGHT_RED=91
    LIGHT_GREEN=92
    YELLOW=93
    LIGHT_BLUE=94
    LIGHT_PURPLE=95
    TURQUOISE=96

    DIRECTORY='di'
    FILE='fi'
    SYMLINK='ln'
    FIFO='pi'
    SOCKET='so'
    BLOCK='bd'
    CHAR='cd'
    ORPHAN='or'
    MISSING='mi'
    EXECUTABLE='ex'
    export CLICOLOR=1
    export LSCOLORS="$DIRECTORY=$BLUE:$FILE=$WHITE:$SYMLINK=$LIGHT_BLUE:$FIFO=$ORANGE:$SOCKET=$YELLOW:$BLOCK=$LIGHT_GREEN:$CHAR=$GREY:$ORPHAN=$YELLOW:$MISSING=$YELLOW:$EXECUTABLE=$RED"

    # Set colors for shell prompt
    BLACK="\e[1;90m"
    RED="\e[1;31m"
    GREEN="\e[1;92m"
    YELLOW="\e[1;93m"
    BLUE="\e[1;94m"
    MAGENTA="\e[1;95m"
    CYAN="\e[1;96m"
    WHITE="\e[1;97m"

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
    GIT_CLEAN=$GREEN
    GIT_DIRTY=$RED
else
    SYSCOLOR=
    GIT_CLEAN=
    GIT_DIRTY=
fi

change_color() {
    echo "\[$1\]"
}

git_branch() {
    if hash git 2>/dev/null && ! git rev-parse --git-dir > /dev/null 2>&1; then
      return 0
    fi

    GIT_BR=$(git branch 2>/dev/null | sed -n '/^\*/s/^\* //p')

    if git diff --quiet 2>/dev/null >&2; then
      GIT_COLOR="$GIT_CLEAN"
    else
      GIT_COLOR="$GIT_DIRTY"
    fi

    echo "\[$GIT_COLOR\]($GIT_BR)"
}

# Takes in the exit code of the last run command as $1
last_char() {
    EXIT=$1
    # Get the right char
    if [[ $EUID -ne 0 ]]; then
        CHAR="\342\235\261"
    else
        CHAR="#"
    fi
    # Get the right color
    if [[ $EXIT == 0 ]]; then
        COLOR=$GREEN
        NON_ZERO=
    else
        COLOR=$RED
        NON_ZERO="($EXIT)"
    fi
    echo "\[$COLOR\]$NON_ZERO$CHAR "
}

make_prompt() {
    EXIT=$?
    LONG_USER_HOST_PATH="$(change_color $SYSCOLOR)[\u$(change_color $RED)@\h$(change_color $BLUE):\w$(change_color $SYSCOLOR)]"
    SHORT_USER_HOST_PATH="$(change_color $SYSCOLOR)[\u$(change_color $RED)@\h$(change_color $BLUE):\W$(change_color $SYSCOLOR)]"
    DATE_TIME="[\D{%Y%m%d %H:%M:%S}]"
    WHITE="\[\033[01;37m\]"
    LONG_PROMPT="$LONG_USER_HOST_PATH$DATE_TIME$(git_branch)\n$(last_char $EXIT)$WHITE"
    SHORT_PROMPT="$SHORT_USER_HOST_PATH$DATE_TIME$(git_branch)\n$(last_char $EXIT)$WHITE"
#    if [[ ${#LONG_PROMPT} -lt $(tput cols) ]]; then
#        echo "$LONG_PROMPT"
#    else
#        echo "$SHORT_PROMPT"
#    fi
    echo "$LONG_PROMPT"
}

PROMPT_COMMAND='PS1=$(make_prompt)'
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

# Source RVM if it exists
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" && export PATH="$PATH:$HOME/.rvm/bin"

# Arch Linux Specific
if hash pacman 2>/dev/null; then
    BASE="/home/$USER/Dropbox/Sync/script"
    alias dbx="$BASE/dropbox.py"
    alias sdbx="sudo sysctl -p; $BASE/dropbox.py"

    alias sgdm="sudo systemctl start gdm"

    alias syu='sudo pacman -Syu'
    alias rs='sudo pacman -Rs'

    alias archstart="sudo sysctl -p; $BASE/dropbox.py start; sudo pacman -Syu"

    if hash redshift; then
        alias redshift='redshift -l 40:124'
    fi

    export PATH=$PATH:$BASE
fi

function open() {
    test $# -lt 1 && echo "Too few arguments"
    test $# -gt 1 && echo "Too many arguments"
    EXTENSION=${1#*.}
    case ${EXTENSION,,} in
        pdf)
            evince "$1"
            ;;
        jpg)
            if hash eog 2>/dev/null; then
                eog "$1"
            else
                xdg-open "$1"
            fi
            ;;
        png)
            if hash eog 2>/dev/null; then
                eog "$1"
            else
                xdg-open "$1"
            fi
            ;;
        *)
            xdg-open "$1"
            ;;
    esac
}

## end .bash_profile ##

