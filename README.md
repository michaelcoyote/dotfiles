dotfiles
========

My basic config files meant to be pulled down and used in different environments.

Clone into .dotfiles like so:

    git clone git@github.com:michaelcoyote/dotfiles.git ~/.dotfiles

To link the files, run the command `DFlink.sh`, and it will automatically create softlinks to the files that haven't already been linked moving any existing files to the `.dotfiles_old` directory.

To add files to the install script, for now edit the `files` variable in the script. If a file lives in a sub directory, replicate the directory structure in the `dotfiles` repo and include the relative path in the `files` variable. The leading dot will be prepended to the link when the `DFlink.sh` script is run.
For example, a file like `.bashrc` should be listed as `bashrc` and named `bashrc` in the `dotfiles` repo.  For a file like the `.ssh/config`, create the `ssh` directory in the repo then place the `config` file within the `ssh` directory. Then list the relative path `ssh\config` in the `files` variable.

Of course it's still possible to manually link an individual file `ln -s .dotfiles/blah ~/.blah`
