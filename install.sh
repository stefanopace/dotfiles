sudo apt install $(cat programs | tr "\n" " ")

while read link; do
  dir=$(echo $link | sed -n -r "s|[^ ]+ ([^ ]+)/[^ ]+$|\1|p" | sed "s|~|$HOME|")
  expanded=$(echo $link | sed "s|~|$HOME|")
  mkdir -p $dir
  ln -sfv $(pwd)/$expanded
done <links

# enable bitmap fonts
sudo rm /etc/fonts/conf.d/70-no-bitmaps.conf
sudo fc-cache -f -v
#1. Enable bitmap font on Ubuntu.
#2. Download the font from here. and extract it to /usr/share/fonts/dina
#3. run "mkfontdir" in the respective font directory.
#4. run "xset fp rehash"
#5. run "fc-cache -f"
#6. check with "fc-list | grep Dina" that Dina is there as medium, bold, italic, and bold italic.
#http://www.donationcoder.com/Forums/bb/index.php?PHPSESSID=72e43enpv13bg758a3kplfrpe5&action=dlattach;topic=7857.0;attach=16190
#http://notepad2.blogspot.com/2010/08/enable-bitmap-font-on-ubuntu.html


