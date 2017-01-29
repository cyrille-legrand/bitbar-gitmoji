#!/bin/bash
export LANG="${LANG:-en_US.UTF-8}"

# Put first parameter in clipboard then exit
if [ -n "$1" ]; then
	echo -n "$1 " | pbcopy
	exit
fi

HERE="$(dirname "$0")"
DATA="$HERE/gitmoji"

# Menubar icon -- white only for now
DARK=$(defaults read -g AppleInterfaceStyle 2>/dev/null || echo "Light")
if [ "$DARK" == "Dark" ] ; then
	echo "| size=9 image=$(base64 "$DATA/_icon_white.png")"
else
	echo "| size=9 image=$(base64 "$DATA/_icon_black.png")"
fi
echo "---"


cat "$DATA/list.txt" | while read emoji code desc; do
	if [ "$emoji" == "-" ] ; then
		echo "---"
		echo "$code $desc | size=9"
	else
		echo "$desc | bash='$0' param1=\"$emoji \" terminal=false size=12 image=$(base64 "$DATA/${code}.png")"
	fi
done
