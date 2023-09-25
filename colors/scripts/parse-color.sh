#!/usr/bin/env bash

palette="#217c0e3c4da6:#d8d81d1d7e7d:#1919c0c06565:#e7e77d7d4545:#000082828e8e:#959528278c8c:#00007d7d7776:#ffffffffffff:#4e4e28288d8d:#ffff3e3ea9a9:#2424c6c66b6b:#ffffa4a46e6e:#0000aaaab9b9:#9f9f4141aaaa:#0000bdbdafaf:#ededfafafefe:#f3f3e5e5f4f4:#04040a091a1a"


if [[ -n "$1" ]]; then
    for line in `grep "*\." $1 | sed -r "s|\*.(.*):\s+.(.*)|\1-\2|"`; do
    
    encoded=( `echo $line | tr '-' ' '` )
    subject=${encoded[0]}
    color=${encoded[1]}

    case "$subject" in
        foreground)
            colors[17]="#$color"
        ;;

        background)
            colors[18]="#$color"
        ;;

        cursorColor)

        ;;
        
        *)
        n=`echo $subject | grep -Eo "[0-9]+"`
        colors[$n]="#$color"
        ;;
    esac
    done

    palette=$(echo ${colors[@]} | tr ' ' ':')
fi

guake --restore-preferences <(echo "[style/font]
palette='$palette'
")