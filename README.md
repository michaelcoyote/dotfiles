dotfiles
========

My basic config files meant to be pulled down and used in different environments.

Clone into .dotfiles like so:

    git clone git@github.com:michaelcoyote/dotfiles.git ~/.dotfiles

To link the files, run the command `DFlink.sh`, and it will automatically create softlinks to the files that haven't already been linked moving any existing files to the `.dotfiles_old` directory.

To add files to the install script, for now edit the `files` variable in the script. 

Of course it's still possible to manually link an individual file `ln -s .dotfiles/blah ~/.blah`
