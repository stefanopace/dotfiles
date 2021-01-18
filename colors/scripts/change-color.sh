#!/usr/bin/env bash

for line in `grep "*\." $1 | sed -r "s|\*.(.*):\s+.(.*)|\1-\2|"`; do
  
  encoded=( `echo $line | tr '-' ' '` )
  subject=${encoded[0]}
  color=${encoded[1]}

  case "$subject" in
    foreground)
      printf "\033]10;#$color\007"
      ;;

    background)
      printf "\033]11;#$color\007"
      ;;

    cursorColor)
      printf "\033]12;#$color\007"
      ;;
    
    *)
      n=`echo $subject | grep -Eo "[0-9]+"`
      printf "\033]4;$n;#$color\007"
      ;;
  esac
done

printf '  ▇▇'

colors="30 31 32 33 34 35 36 37"

for color in 30 31 32 33 34 35 36 37 ; do
	for shade in 0 1 ; do
		printf "\033[$shade;${color}m▇▇"
	done
done
printf '\033[0m'
echo