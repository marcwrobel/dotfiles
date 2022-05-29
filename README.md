# dotfiles

Various config files and scripts.

## Installation and usage

    sudo apt install stow
    git clone https://github.com/marcwrobel/dotfiles.git ~/.config/dotfiles
    cd .config/dotfiles
    stow -nv --no-folding -t $HOME -d . . .npm-packages .bashrc.d
