export TERM=xterm-256color
export CLICOLOR=0
# export LSCOLORS=ExFxBxDxCxegedabagacad
alias ls='ls -GFh'
alias ll='ls -l'

if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
else
    color_prompt=
fi

if [ "$color_prompt" = yes ]; then
    export PS1='\[\e[01;32m\]\u\[\e[00m\]:\[\e[01;34m\]\W$(parse_git_branch)\[\e[00m\]$ '
    export SUDO_PS1="\n[\t] \[\e[33;01;41m\]\u@\H\[\e[0m\]:\$PWD\n"
else
    export PS1="\n[\t] \u@\H:\$PWD\n"
fi

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

