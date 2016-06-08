# ~/.bash_aliases: executed by ~/.bashrc.

# enable color support for various commands
if [ -x /usr/bin/dircolors ]; then
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# ls
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

# rm
alias rm="rm --interactive=once"
