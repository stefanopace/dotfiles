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

