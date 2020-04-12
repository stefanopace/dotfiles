sudo apt install $(cat programs | tr "\n" " ")

while read link; do
  dir=$(echo $link | sed -n -r "s|[^ ]+ ([^ ]+)/[^ ]+$|\1|p" | sed "s|~|$HOME|")
  expanded=$(echo $link | sed "s|~|$HOME|")
  mkdir -p $dir
  ln -sfv $(pwd)/$expanded
done <links
