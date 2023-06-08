# vim syntax=sh
alias grep='grep --color=auto'
alias ls='ls --color=auto -p'
alias ll='ls -lahFtr'
alias la='ls -A'

alias cdow='cd ~/downloads'
alias cdot='cd ~/dotfiles'
alias cdside='cd ~/side-projects'
alias cdwip='cd ~/work-in-progress'
alias cdproj='cd ~/projects'

alias each='xargs -L1 -I{}'
alias gatto='cat'
alias meno='less'
alias reloadbashrc='source ~/.bashrc'
alias jsoncat='python -m json.tool'
alias clip="tee /dev/tty | perl -pe 'chomp if eof' | xclip -sel clip"
alias open='xdg-open'
alias voc='cat /usr/share/dict/words'
alias ask='zenity'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias dockerps='docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}" | sed -E "s|  +|  |"'
alias bat='batcat'

alias zoomin='echo -e "\033]710;D2Coding:style=Regular:pixelsize=20:antialias=true\007\033]711;D2Coding:style=Bold:pixelsize=20:antialias=true\007"'
alias zoomout='echo -e "\033]710;xft:Gohu GohuFont:style=Regular:pixelsize=14:antialias=false\007\033]711;xft:Gohu GohuFont:style=Bold:pixelsize=14:antialias=false\007"'

alias vimcheatsheet='surf https://vim.rtorr.com/lang/it'
alias j='eeks --configurations ~/dotfiles/eeks-configs/izi.json --source ~/dotfiles/eeks-configs/render-weather.sh'

title () {
	echo -en "\x1b]0;$@\x07"
}

ssh-generate-for-github () {
	if test ! -f "~/.ssh/id_rsa.pub"; then
		if test -f "~/.ssh/id_rsa"; then
			echo "esiste gia un file id_rsa"
			exit 1
		fi
		ssh-keygen -t rsa -b 4096 -C "stefanopace01@gmail.com" -f "/home/stefano/.ssh/id_rsa"
		chmod go-rwx ~/.ssh/id_rsa
	fi
	eval "$(ssh-agent -s)"
	ssh-add ~/.ssh/id_rsa
	cat ~/.ssh/id_rsa.pub | clip
	echo "https://github.com/settings/keys"
}

PATH=$PATH:/home/stefano/tools/bin

set -o vi
export EDITOR=vim

export NOTE_HOME=~/tools/notes
bind '"jk":vi-movement-mode'
# If there are multiple matches for completion, Tab should cycle through them
bind 'TAB:menu-complete'
# And Shift-Tab should cycle backwards
bind '"\e[Z": menu-complete-backward'

# Display a list of the matching files
bind "set show-all-if-ambiguous on"

# Perform partial (common) completion on the first Tab press, only start
# cycling full results on the second Tab press (from bash version 5)
bind "set menu-complete-display-prefix on"

PS1='$(if [ $? -ne 0 ]; then echo "\[\e[37;41;1m\]\W\[\e[40;31m\]\[\e[0m\]\[\e[40;1m\]"; else echo "\[\e[30;106;1m\]\W\[\e[40;96m\]\[\e[0m\]\[\e[40;1m\]"; fi)\[\e[K\]'
PS2='│\[\e[K\]'
PS0='\[\e[0m\]\[\e[K\]'