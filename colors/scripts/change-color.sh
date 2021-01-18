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


      #\033]11;#C0C0C0\007\033]10;#C0C0C0\007\033]4;0;#C0C0C0\007\033]4;1;#C0C0C0\007\033]4;2;#C0C0C0\007\033]4;3;#C0C0C0\007\033]4;4;#C0C0C0\007\033]4;5;#C0C0C0\007\033]4;6;#C0C0C0\007\033]4;7;#C0C0C0\007\033]4;8;#C0C0C0\007\033]4;9;#C0C0C0\007\033]4;10;#C0C0C0\007\033]4;11;#C0C0C0\007\033]4;12;#C0C0C0\007\033]4;13;#C0C0C0\007\033]4;14;#C0C0C0\007\033]4;15;#C0C0C0\007
  esac
done