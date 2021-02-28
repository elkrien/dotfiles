#### NO GREETING WHEN START

function fish_greeting
end

#### FISH COLORS

export MICRO_TRUECOLOR=1

### ZOXIDE

zoxide init fish | source


#### "BAT" AS A MANPAGER

set -x MANPAGER "sh -c 'col -bx | bat -l man -p'" 


#### ALIAS

alias cat="bat"
alias ls="exa -abghHlS --group-directories-first"
alias update="sudo pacman -Syu"
alias df="duf"

#### FISH AUTOSTART
neofetch
starship init fish | source



