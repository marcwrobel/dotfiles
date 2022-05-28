# Set a fancy prompt (with git support).
# See https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh.

GIT_PS1_SHOWCOLORHINTS=true # require the use of PROMPT_COMMAND
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWUPSTREAM='verbose'

PROMPT='"\u@\h:\w" "\\\$ "'
if [[ -e /usr/lib/git-core/git-sh-prompt ]]; then
	. /usr/lib/git-core/git-sh-prompt
  PROMPT='__git_ps1 "\u@\h:\w" "\\\$ "'
fi

if [ -z "$PROMPT_COMMAND" ]; then
  export PROMPT_COMMAND="$PROMPT"
else
  export PROMPT_COMMAND="$PROMPT_COMMAND; $PROMPT"
fi
