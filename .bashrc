case $- in
    *i*) ;;
      *) return;;
esac

shopt -s checkwinsize

source ~/.alias_and_functions
source ~/.office_alias_and_functions
source ~/.prompt

export PATH=$PATH:/home/stefano/Scrivania/utilities/tools/bin
export PATH=$PATH:/home/stefano/tools/bin
export PATH=$PATH:/home/stefano/apps/nodejs/bin
export PATH=$PATH:/home/stefano/Scrivania/work-in-progress/utilities/versioning/scripts
export NOTE_HOME=/home/stefano/Scrivania/utilities/tools/notes
# fix per applicazioni con gui in java in dwm (es. pycharm)
export _JAVA_AWT_WM_NONREPARENTING=1

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -f /usr/share/bash-completion/completions/fzf ] && source /usr/share/bash-completion/completions/fzf

# always exit with 0
true
