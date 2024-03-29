#!/bin/env bash

# enable color support grep
if [ -x /usr/bin/dircolors ]; then
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi
