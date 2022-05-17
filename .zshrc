# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#################
# Antigen
#################
source ~/.antigen.zsh
source ~/.zsh_aliases


#################
# Core
#################

# don't get hung up on control-flow sigs (e.g. CTRL+S)
# stty -ixon

# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return;;
esac

DISABLE_AUTO_TITLE=true
ENABLE_CORRECTION=true

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
setopt APPEND_HISTORY

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
setopt dotglob

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

export TERM=xterm-256color
[ -n "$TMUX" ] && export TERM=screen-256color

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=0'

# zsh vi mode
export VISUAL=vim
export EDITOR="$VISUAL"
# mimic some vim-keybinds in zsh vi mode
bindkey -M viins "^?" backward-delete-char
bindkey -v

# if we have a 'local' vim install, don't use the default
if [ -h "$HOME/local/bin/vim" ]; then
    alias vim="$HOME/local/bin/vim"
fi

# added by allison 5/24/19 for universal extraction
function extract {
    if [ -z "$1" ]; then
        # display usage if no parameters given
        echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
        echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
        return 1
    else
        for n in $@
        do
            if [ -f "$n" ] ; then
                case "${n%,}" in
                    *.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar)
                        tar xvf "$n"       ;;
                    *.lzma)      unlzma ./"$n"      ;;
                    *.bz2)       bunzip2 ./"$n"     ;;
                    *.rar)       unrar x -ad ./"$n" ;;
                    *.gz)        gunzip ./"$n"      ;;
                    *.zip)       unzip ./"$n"       ;;
                    *.z)         uncompress ./"$n"  ;;
                    *.7z|*.arj|*.cab|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.rpm|*.udf|*.wim|*.xar)
                        7z x ./"$n"        ;;
                    *.xz)        unxz ./"$n"        ;;
                    *.exe)       cabextract ./"$n"  ;;
                    *)
                        echo "extract: '$n' - unknown archive method"
                        return 1
                        ;;
                esac
            else
                echo "'$n' - file does not exist"
                return 1
            fi
        done
    fi
}

# added by fzf installer 10/8/19
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Powerlevel10k theme customizations
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# added for antigen
source /opt/homebrew/opt/powerlevel10k/powerlevel10k.zsh-theme

