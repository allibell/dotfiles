# Setup fzf
# ---------
if [[ ! "$PATH" == */home/allison/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/allison/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/allison/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/allison/.fzf/shell/key-bindings.zsh"
