# Enable options, see https://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html

# Correct minor errors in the spelling of a directory component in a cd command.
shopt -s cdspell

# Check the window size after each command and, if necessary, update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Match all files and zero or more directories and subdirectories with "**".
shopt -s globstar

# Append to the history file, don't overwrite it.
shopt -s histappend

# Set history length.
HISTSIZE=1000
HISTFILESIZE=1000

# Don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# Save the history after each command finishes
export PROMPT_COMMAND="history -a"
