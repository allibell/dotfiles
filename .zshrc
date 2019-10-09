#################
# Antigen
#################
source ~/antigen.zsh
source ~/.theme
source ~/.fonts/*.sh
source ~/.zsh_aliases

antigen use oh-my-zsh
antigen bundle command-not-found
antigen bundle common-aliases
antigen bundle tmux
# workaround for https://github.com/zsh-users/antigen/issues/675
THEME=romkatv/powerlevel10k
antigen list | grep $THEME; if [ $? -ne 0 ]; then antigen theme $THEME; fi
antigen apply


#################
# Core
#################

# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

export TERM=xterm-256color
[ -n "$TMUX" ] && export TERM=screen-256color

# added by Anaconda3 2018.12 installer
# >>> conda init >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$(CONDA_REPORT_ERRORS=false '/home/allison/anaconda3/bin/conda' shell.bash hook 2> /dev/null)"
if [ $? -eq 0 ]; then
    \eval "$__conda_setup"
else
    if [ -f "/home/allison/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/allison/anaconda3/etc/profile.d/conda.sh"
        CONDA_CHANGEPS1=false conda activate base
    else
        \export PATH="/home/allison/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda init <<<


# added by allison 1/3/19 for android studio
export PATH=$PATH:/usr/local/android-studio/bin

# added by allison 1/3/19 for flutter
export PATH=$PATH:~/development/flutter/bin

# added by allison 1/6/19 for vi keybindings in bash
set -o vi

# added by allison 2/28/19 for apache maven
export PATH=$PATH:~/development/apache-maven-3.6.0/bin

# added by allison 4/6/19 for mongo
export PATH=$PATH:~/development/mongodb-linux-x86_64-ubuntu1804-4.0.8/bin

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

# added by allison 8/11/19 for VIM!
export VISUAL=vim
export EDITOR="$VISUAL"

# added by fzf installer 10/8/19
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

typeset POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR=!?!?
