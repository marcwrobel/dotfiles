"------------------------------------------------------------
" Features

" Set 'nocompatible' to ward off unexpected things that your distro might have made, as well as sanely reset options when re-sourcing .vimrc
set nocompatible

" Attempt to determine the type of a file based on its name and possibly its contents.  Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
"filetype indent plugin on " Inactivated because the copy of code with single line comments breaks.

" Enable syntax highlighting
set background=dark
set t_Co=256
syntax on

" Make tabs and eol spaces visible
set listchars=tab:>-,trail:·

"------------------------------------------------------------
" Must have options
"

" Increase history from to 1000 (default = 20)
set history=1000

" One of the most important options to activate. Allows you to switch from an unsaved buffer without saving it first. Also allows you to keep an undo
" history for multiple files. Vim will complain if you try to quit without saving, and swap files will keep you safe if your computer crashes.
set hidden

" Better command-line completion
set wildmenu

" Show partial commands in the last line of the screen
set showcmd

" Show the filename in the window titlebar
set title

" Highlight searches (use <C-L> to temporarily turn off highlighting; see the mapping of <C-L> below)
set hlsearch

" Highlight searches dynamically as pattern is typed
set incsearch

" Modelines have historically been a source of security vulnerabilities.  As such, it may be a good idea to disable them and use the securemodelines script, 
" <http://www.vim.org/scripts/script.php?script_id=1876>.
" set nomodeline


"------------------------------------------------------------
" Usability options
"

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" When opening a new line and no filetype-specific indenting is enabled, keep the same indent as the line you're currently on. Useful for READMEs, etc.
"set autoindent " Inactivated because I do not like it that much...

" Stop certain movements from always going to the first character of a line. While this behaviour deviates from that of Vi, it does what most users coming from other editors would expect.
set nostartofline

" Display the cursor position on the last line of the screen or in the status line of a window
set ruler

" Always display the status line, even if only one window is displayed
set laststatus=2

" Instead of failing a command because of unsaved changes, instead raise a dialogue asking if you wish to save changed files.
set confirm

" Use visual bell instead of beeping when doing something wrong
set visualbell

" And reset the terminal code for the visual bell.  If visualbell is set, and this line is also included, vim will neither flash nor beep.  If visualbell is unset, this does nothing.
set t_vb=

" Disable mouse usage
set mouse=

" Set the command window height to 2 lines, to avoid many cases of having to "press <Enter> to continue"
set cmdheight=2

" Display line numbers on the left
"set number

" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200


"------------------------------------------------------------
" Indentation options
"

" Indentation settings for using 2 spaces instead of tabs. Do not change 'tabstop' from its default value of 8 with this setup.
set shiftwidth=2
set softtabstop=2
set expandtab
