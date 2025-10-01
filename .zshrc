if [ -z "$CURSOR_TRACE_ID" ]; then
    # Load interactive themes, plugins, etc. here
    # For example, for Oh My Zsh:
    # source $ZSH/oh-my-zsh.sh
    #
    # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
    # Initialization code that may require console input (password prompts, [y/n]
    # confirmations, etc.) must go above this block; everything else may go below.
    if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
      source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
    fi
    # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
    [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

    export TERM=xterm-256color
fi



# homebrew rox
export PATH="/opt/homebrew/bin:$PATH"

source ~/.zsh_aliases


# for gnu grep
export PATH="/opt/homebrew/opt/grep/libexec/gnubin:$PATH"

# ruby lol
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"


# Created by `pipx` on 2025-06-12 04:15:45
export PATH="$PATH:/Users/allibell/.local/bin"
export PATH="$HOME/src/depot_tools:$PATH"
export PATH="$HOME/chromium/src/depot_tools:$PATH"
export PATH="$HOME/src/depot_tools:$PATH"

# Open Zed on the given path(s), or current directory if none
zed() {
  if [[ $# -eq 0 ]]; then
    open -a "Zed" .
  else
    open -a "Zed" "$@"
  fi
}
