# do macos only things.
if uname -a |grep --quiet Darwin ; then
    if [ -f "$(brew --prefix)"/etc/bash_completion ]; then
      . "$(brew --prefix)"/etc/bash_completion
    fi
fi

if [ -f ~/.bashrc ]; then . ~/.bashrc; fi 
export PATH=/usr/local/lib:/usr/local/bin:$PATH
