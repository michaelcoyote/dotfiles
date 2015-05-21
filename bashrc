# Bash knows 3 diferent shells: normal shell, interactive shell, login shell.
# ~/.bashrc is read for interactive shells and ~/.profile & ~/.bash_profile 
# is read for login shells.  

# Weird bit of $TERM/tset magic 
# I think it should set the backspace char to erase
#if ! [ $TERM ] ; then
#    eval `tset -s -Q`
#    case $TERM in
#      con*|vt100) tset -Q -e ^?
#        ;;
#    esac
#fi

# set up vim as the editor of choice
if test -x `which vim` ; then
    EDITOR="`which vim`";
    export EDITOR;
else
    EDITOR="`which vi`";
    export EDITOR;
fi

#set up less as the editor of choice
if test -x `which less`; then
    PAGER="`which less`";
    export PAGER
    alias more='less'
    export LESSCHARSET='utf-8'
    # Use this if lesspipe.sh exists.
    # export LESSOPEN='|/usr/bin/lesspipe.sh %s 2>&-'
    #
    # set ignore case, hilite search, disable term init, 
    # move row-4 rows per page
    export LESS='-i -g -X -z-4 '

    # LESS man page colors (makes Man pages more readable).
    export LESS_TERMCAP_mb=$'\E[01;31m'     # Blink Start
    export LESS_TERMCAP_md=$'\E[01;31m'     # Bold Start
    export LESS_TERMCAP_me=$'\E[0m'         # Mode End
    export LESS_TERMCAP_se=$'\E[0m'         # Standout Mode End
    export LESS_TERMCAP_so=$'\E[01;44;33m'  # Standout Mode Start
    export LESS_TERMCAP_ue=$'\E[0m'         # Underline End
    export LESS_TERMCAP_us=$'\E[01;32m'     # Underline Start
fi

#  shell settings
ulimit -S -c 0          # turn off coredumps
set -o notify           # notify when bg jobs terminate

shopt -s cdspell        # correct pathnames for cd command
shopt -s checkjobs      # check for running jobs before exit
shopt -s checkwinsize   # Check and update term size after every command
shopt -s cmdhist        # save multiline cmds in same history entry
shopt -s no_empty_cmd_completion  # no tab completion for empty prompt
shopt -s histappend histreedit histverify 
shopt -s extglob        # extended pattern matching & programmable completion

# Disable options:
shopt -u mailwarn
unset MAILCHECK        # Don't want my shell to warn me of incoming mail

# History stuff
#  TODO This may be better to implement
#   http://unix.stackexchange.com/questions/1288/preserve-bash-history-in-multiple-terminal-windows
export HISTSIZE=9000
export HISTCONTROL=ignorespace:ignoredups
export PROMPT_COMMAND="history -a"

# source in stuff from files if they exist.
test -e ~/.alias && . ~/.alias
test -e ~/.bash_functions && . ~/.bash_functions
test -e ~/.bashs && . ~/.bashs
# bring in any locals last so they override
test -e ~/.bash_local && . ~/.bash_local


export PS1 PS2
umask 022


