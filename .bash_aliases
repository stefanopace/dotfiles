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

export EDITOR=vim

export NOTE_HOME=~/tools/notes

bind -x '"\C-l": echo -e "\[\e[0m\]"; clear;'

bind "set completion-ignore-case on"
bind "set colored-stats on"

mkdir -p "/dev/shm/promptlen/"
echo "0" > "/dev/shm/promptlen/$$"

function roundseconds (){
  # rounds a number to 3 decimal places
  echo m=$1";h=0.5;scale=4;t=1000;if(m<0) h=-0.5;a=m*t+h;scale=3;a/t;" | bc
}

function bash_getstarttime (){
  # places the epoch time in ns into shared memory
  date +%s.%N >"/dev/shm/${USER}.bashtime.${1}"
}

function bash_getstoptime (){
  # reads stored epoch time and subtracts from current
  local endtime=$(date +%s.%N)
  local starttime=$(cat /dev/shm/${USER}.bashtime.${1})
  roundseconds $(echo $(eval echo "$endtime - $starttime") | bc)
}

ROOTPID=$BASHPID
bash_getstarttime $ROOTPID

if [ -n "$PS1" ]; then
	PS1='$(
		echo -en "\[\e[0m\]"
		ec=$?;
		if [ ${__cmdnbary[\#]+"set"} ]; then
			true
		else
			et=$(bash_getstoptime $ROOTPID);
			if [[ ${#et} -ge 5 ]]; then	
				et=${et//./·}
				et=${et//0/⁰}
				et=${et//1/¹}
				et=${et//2/²}
				et=${et//3/³}
				et=${et//4/⁴}
				et=${et//5/⁵}
				et=${et//6/⁶}
				et=${et//7/⁷}
				et=${et//8/⁸}
				et=${et//9/⁹}
				echo -en "$et";
			fi
		fi
		if [ $ec -ne 0 ]; then 
			echo -en "\[\e[31;49;7m\]\[\e[27m\e[37;41;1m\]$ec\[\e[106;31m\]\[\e[0m\e[40;1m\]"; 
		else 
			echo -en "\[\e[96;49;1;7m\]\[\e[27m\]"
		fi
		echo -e "\[\e[30;106;1m\]\W\[\e[40;96m\]\[\e[0m\e[40;1m\e[K\]";
	)${__cmdnbary[\#]=}'
	PS0='\[\e[0m\e[K\]$(bash_getstarttime $ROOTPID)'
	PS2='$(
		ec=$?;
		if [ $ec -ne 0 ]; then 
			echo -en "\[\e[27m\e[31;41;1m\]$ec \[\e[106;31m\]\[\e[0m\e[40;1m\]"; 
		fi
		echo -e "\[\e[96;106;1;7m\] \W\[\e[96;40;27;39m\e[K\] ";
	)'
fi

function runonexit (){
  rm /dev/shm/${USER}.bashtime.${ROOTPID}
}

trap runonexit EXIT

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
