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

#### SPARK ####

set -g spark_version 1.0.0

complete -xc spark -n __fish_use_subcommand -a --help -d "Show usage help"
complete -xc spark -n __fish_use_subcommand -a --version -d "$spark_version"
complete -xc spark -n __fish_use_subcommand -a --min -d "Minimum range value"
complete -xc spark -n __fish_use_subcommand -a --max -d "Maximum range value"

function spark -d "sparkline generator"
    if isatty
        switch "$argv"
            case {,-}-v{ersion,}
                echo "spark version $spark_version"
            case {,-}-h{elp,}
                echo "usage: spark [--min=<n> --max=<n>] <numbers...>  Draw sparklines"
                echo "examples:"
                echo "       spark 1 2 3 4"
                echo "       seq 100 | sort -R | spark"
                echo "       awk \\\$0=length spark.fish | spark"
            case \*
                echo $argv | spark $argv
        end
        return
    end

    command awk -v FS="[[:space:],]*" -v argv="$argv" '
        BEGIN {
            min = match(argv, /--min=[0-9]+/) ? substr(argv, RSTART + 6, RLENGTH - 6) + 0 : ""
            max = match(argv, /--max=[0-9]+/) ? substr(argv, RSTART + 6, RLENGTH - 6) + 0 : ""
        }
        {
            for (i = j = 1; i <= NF; i++) {
                if ($i ~ /^--/) continue
                if ($i !~ /^-?[0-9]/) data[count + j++] = ""
                else {
                    v = data[count + j++] = int($i)
                    if (max == "" && min == "") max = min = v
                    if (max < v) max = v
                    if (min > v ) min = v
                }
            }
            count += j - 1
        }
        END {
            n = split(min == max && max ? "▅ ▅" : "▁ ▂ ▃ ▄ ▅ ▆ ▇ █", blocks, " ")
            scale = (scale = int(256 * (max - min) / (n - 1))) ? scale : 1
            for (i = 1; i <= count; i++)
                out = out (data[i] == "" ? " " : blocks[idx = int(256 * (data[i] - min) / scale) + 1])
            print out
        }
    '
end

function letters
    cat $argv | awk -vFS='' '{for(i=1;i<=NF;i++){ if($i~/[a-zA-Z]/) { w[tolower($i)]++} } }END{for(i in w) print i,w[i]}' | sort | cut -c 3- | spark | lolcat
    printf  '%s\n' 'abcdefghijklmnopqrstuvwxyz'  ' ' | lolcat
end

function commits
    git log --author="$argv" --format=format:%ad --date=short | uniq -c | awk '{print $1}' | spark | lolcat
end

#### ALIASES ####

alias cl='clear; echo; echo; seq 1 (tput cols) | sort -R | spark | lolcat; echo; echo'

# ls change to lsd
# alias ls='lsd -l --icon-theme unicode --group-dirs first' # standard listing
# alias la='lsd -la --icon-theme unicode --group-dirs first'  # all files and dirs
# alias lt='lsd --tree --icon-theme unicode --group-dirs first' # tree listing

# ls change to exa
alias ls='exa -lgh --color=always --group-directories-first' # standard listing
alias la='exa -lagh --color=always --group-directories-first'  # all files and dirs
alias lt='exa -aT --color=always --group-directories-first' # tree listing
alias l.='exa -a | egrep "^\."' # only hidden (.)


# navigation
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# cat change to bat
alias cat='bat'

# top change to ytop
alias top='ytop'

# update system
alias update='sudo pacman -Syu'

# df change to duf
alias df='duf'

# neofetch
alias fetch='neofetch'
alias fetchc='neofetch | lolcat'

#### FISH AUTOSTART ####

echo; echo; seq 1 (tput cols) | sort -R | spark | lolcat; echo; echo

#### INIT STARSHIP ####

starship init fish | source



