# bash_profile is executed for login shells and
# OSX by default runs a login shell every time,
# so this exists to source our bashrc file to insure
# we have a consistent login environment avalible 
# no matter what system we are logging into and 
# no matter how we log in.

# do macos only things.
#if uname -a |grep --quiet Darwin ; then
#    # shellcheck source=/dev/null
#    if [ -f "$(brew --prefix)"/etc/bash_completion ]; then
#      . "$(brew --prefix)"/etc/bash_completion
#    fi
#fi
# source bashrc
# shellcheck source=/dev/null
if [ -f ~/.bashrc ]; then . ~/.bashrc; fi
# pick up PATH here~
export PATH=/usr/local/lib:/usr/local/bin:$PATH
# add local bin, necessary for pipx
if [ -d ${HOME}/.local/bin ]; then export PATH=${HOME}/.local/bin:$PATH; fi

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init.bash 2>/dev/null || :
