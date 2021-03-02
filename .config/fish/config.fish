#### NO GREETING WHEN START ####

function fish_greeting
end

#### MICRO COLORS ####

export MICRO_TRUECOLOR=1

#### ZOXIDE ####

zoxide init fish | source

#### "BAT" AS A MANPAGER

set -x MANPAGER "sh -c 'col -bx | bat -l man -p'" 

#### USE !! and !$ IN FISH ####

function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end

function __history_previous_command_arguments
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end

# The bindings for !! and !$
  bind ! __history_previous_command
  bind '$' __history_previous_command_arguments

#### ALIASES ####

# ls change to exa
alias ls='exa -al --color=always --group-directories-first' # standard listing
alias la='exa -a --color=always --group-directories-first'  # all files and dirs
alias ll='exa -l --color=always --group-directories-first'  # long format
alias lt='exa -aT --color=always --group-directories-first' # tree listing

# cat change to bat
alias cat='bat'

# update system
alias update='sudo pacman -Syu'

# df change to duf
alias df='duf'

#### FISH AUTOSTART ####
neofetch

#### INIT STARSHIP ####

starship init fish | source



