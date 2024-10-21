
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /Users/xc/opt/anaconda3/bin/conda "shell.fish" hook $argv | source
# <<< conda initialize <<<


set -q XDG_CONFIG_HOME || set XDG_CONFIG_HOME "$HOME/.config"
source $XDG_CONFIG_HOME/fish/prompt.fish
source $XDG_CONFIG_HOME/fish/colors.fish
