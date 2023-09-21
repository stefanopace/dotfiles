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
alias vimcheatsheet='surf https://vim.rtorr.com/lang/it'
alias j='eeks --configurations ~/dotfiles/eeks-configs/izi.json --source ~/dotfiles/eeks-configs/render-weather.sh'

alias neofetch='neofetch --ascii ~/dotfiles/.coders_logo --ascii_colors 4 7'

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

bind -x '"\C-l": echo -e "\[\e[0m\]"; clear;'
bind 'TAB:menu-complete'
bind '"\e[Z": menu-complete-backward'
bind "set show-all-if-ambiguous on"
bind "set menu-complete-display-prefix on"

echo "0" > "/dev/shm/promptlen$$"

if [ -n "$PS1" ]; then
	#PS1='\[\e[0;0H\]$(if [ $? -ne 0 ]; then echo "\[\e[37;41;1m\]\W\[\e[40;31m\]\[\e[s\]\[\e[0m\]\[\e[40;1m\]"; else echo "\[\e[30;106;1m\]\W\[\e[40;96m\]\[\e[s\]\[\e[0m\]\[\e[40;1m\]"; fi)\[\e[K\]'
	#PS0='\[\e[0m\]\[\e[2J\]'

	PS1='$(
		ec=$?;
		if [ ${__cmdnbary[\#]+"set"} ]; then
			nl="$(cat /dev/shm/promptlen$$)";
			let "nl=nl+1";
			echo "$nl" > "/dev/shm/promptlen$$"
		else  
			nl="0"
			echo "0" > "/dev/shm/promptlen$$"
		fi
		if [ $nl -eq 1 ]; then
			echo -en "\e[1A"
		fi
		if [ $nl -gt 1 ]; then
			echo -en "\e[2A"
			echo -en "\e[0m\e[K\n"
		fi
		branch=$(git status -sb 2> /dev/null | head -n 1 | colrm 1 3)
		bar=""
		if [ -n "$branch" ]; then
			bar="[$branch]"
		fi
		if [ $nl -gt 0 ]; then
			echo -en "\e[106m\e[K\[\e[96;49;1;7m\]█\[\e[0;7;96;40m\]$bar\[\e[96;40;1;7m\]\[\e[27m\]\n"
		fi
		if [ $ec -ne 0 ]; then 
			echo -en "\[\e[31;49;7m\]\[\e[27m\e[37;41;1m\]$ec\[\e[106;31m\]\[\e[0m\e[40;1m\]"; 
		else 
			echo -en "\[\e[96;49;1;7m\]\[\e[27m\]"
		fi
		echo -e "\[\e[30;106;1m\]\W\[\e[40;96m\]\[\e[0m\e[40;1m\e[K\]";
	)${__cmdnbary[\#]=}'
	PS0='\[\e[0m\e[K\]'
	PS2='\[\e[96;40;1m\]▌\[\e[39m\e[K\]'

	# PS1='$(if [ $? -ne 0 ]; then tput cup `tput lines`; echo -e "\e[37;41;1m\W\e[40;31m\e[0m\e[40;1m"; else tput cup `tput lines`; echo "\e[30;106;1m\W\e[40;96m\e[0m\e[40;1m"; fi)\e[K'
	# PS0='$(tput reset)'
	# PS2='│\e[K'
fi

if command -v tmux &> /dev/null && [ -n "$PS1" ] && [ -n "$GUAKE_TAB_UUID" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux new-session -A -s 0
fi

function watcha {
    watch -n 300 "python3 ~/work-in-progress/swift.py -a 2> /dev/null"
}

function watchswift {
    watch -n 300 "python3 ~/work-in-progress/swift.py 2> /dev/null"
}

alias auto="python3 ~/work-in-progress/swift.py -a 2> /dev/null"
alias swift="python3 ~/work-in-progress/swift.py 2> /dev/null"

export BC_ENV_ARGS="-lq"

#bind 'set colored-stats on'
# preexec () { 
# 	true
# 	#echo -e "\e[0m\e[2J"
# }
# preexec_invoke_exec () {
#     [ -n "$COMP_LINE" ] && return  # do nothing if completing
#     [ "$BASH_COMMAND" = "$PROMPT_COMMAND" ] && return # don't cause a preexec for $PROMPT_COMMAND
#     preexec
# }
# trap 'preexec_invoke_exec' DEBUG
