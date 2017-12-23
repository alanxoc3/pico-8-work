if [ "$1" ] && [ -d $1 ]; then
	cd $1
else
	(>&2 echo "Empty parameter.")
	exit
fi

DIRS=""
for f in ./src ./lib ./res.p8; do
	if [ -e $f ]; then
		DIRS="$f $DIRS"
	fi
done

inotifywait -e close_write,moved_to,create -m $DIRS |
while read -r directory; do
  echo "'$directory' was changed."
  make > /dev/null
done
