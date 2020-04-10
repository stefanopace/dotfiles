case $- in
    *i*) ;;
      *) return;;
esac

shopt -s checkwinsize

source ~/.alias_and_functions
source ~/.office_alias_and_functions
source ~/.prompt

export PATH=$PATH:/home/stefano/Scrivania/utilities/tools/bin

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
