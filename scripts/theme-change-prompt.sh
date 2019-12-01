#!/bin/bash

SDIR="$HOME/.config/polybar/scripts"
CURRENT=light
UPDATE="$SDIR/theme-change.sh $CURRENT"

eval "$(xdotool getmouselocation --shell)"
eval "$(xdotool getdisplaygeometry --shell)"

if [ "$Y" -lt "$((HEIGHT/2))" ]; then
	YSET=35
	if [ "$X" -gt "$(((WIDTH*2)/3))" ]; then #Right side
			LOC=3
			XSET=-10
		elif [ "$X" -lt "$((WIDTH/3))" ]; then #Left side
			LOC=1
			XSET=10
		else #Center
			LOC=2
	fi

elif [ "$Y" -gt "$((HEIGHT/2))" ]; then
	YSET=-35

	if [ "$X" -gt "$(((WIDTH*2)/3))" ]; then #Right side
				LOC=5
				XSET=-10
			elif [ "$X" -lt "$((WIDTH/3))" ]; then #Left side
				LOC=7
				XSET=10
			else #Center
				LOC=6
	fi
fi

position="rofi -sep | -dmenu -i  -location $LOC -xoffset $XSET -yoffset $YSET -hide-scrollbar"
colors="  Pywal Colors|👕 black|👕 white |👕 red|👕 lime|👕 blue|👕 yellow|👕 aqua|👕 fuchsia|👕 silver|👕 gray|👕 maroon|👕 olive|👕 green|👕 purple|👕 teal|👕 navy|👕 pink"
theme="🔆 light|🔆 lighter|🌜 dark|🌜 darker"


select_theme(){
	
	case "$MENU4" in
		*light) $SDIR/theme-change.sh light ;;
		*lighter) $SDIR/theme-change.sh lighter ;;
		*dark) $SDIR/theme-change.sh dark ;;
		*darker) $SDIR/theme-change.sh darker ;;
	esac
}

select_color1(){
	MENU3="$($position -p Light_Color -columns 3 -lines 6 -width 30 <<<$colors)"
	case "$MENU3" in
		*black) sed -i -e "0,/^color1/ s/color1.*/color1='$\{colors.black}'/" $SDIR/theme-change.sh ;;
		*white) sed -i -e "0,/^color1/ s/color1.*/color1='$\{colors.white}'/" $SDIR/theme-change.sh ;;
		*red) sed -i -e "0,/^color1/ s/color1.*/color1='$\{colors.red}'/" $SDIR/theme-change.sh ;;
		*lime) sed -i -e "0,/^color1/ s/color1.*/color1='$\{colors.lime}'/" $SDIR/theme-change.sh ;;
		*blue) sed -i -e "0,/^color1/ s/color1.*/color1='$\{colors.blue}'/" $SDIR/theme-change.sh ;; 
		*yellow) sed -i -e "0,/^color1/ s/color1.*/color1='$\{colors.yellow}'/" $SDIR/theme-change.sh ;;
		*aqua) sed -i -e "0,/^color1/ s/color1.*/color1='$\{colors.aqua}'/" $SDIR/theme-change.sh ;;
		*fuchsia) sed -i -e "0,/^color1/ s/color1.*/color1='$\{colors.fuchsia}'/" $SDIR/theme-change.sh ;;
		*silver) sed -i -e "0,/^color1/ s/color1.*/color1='$\{colors.silver}'/" $SDIR/theme-change.sh ;;
		*gray) sed -i -e "0,/^color1/ s/color1.*/color1='$\{colors.gray}'/" $SDIR/theme-change.sh ;;
		*maroon) sed -i -e "0,/^color1/ s/color1.*/color1='$\{colors.maroon}'/" $SDIR/theme-change.sh ;;
		*olive) sed -i -e "0,/^color1/ s/color1.*/color1='$\{colors.olive}'/" $SDIR/theme-change.sh ;;
		*green) sed -i -e "0,/^color1/ s/color1.*/color1='$\{colors.green}'/" $SDIR/theme-change.sh ;;
		*purple) sed -i -e "0,/^color1/ s/color1.*/color1='$\{colors.purple}'/" $SDIR/theme-change.sh ;;
		*teal) sed -i -e "0,/^color1/ s/color1.*/color1='$\{colors.teal}'/" $SDIR/theme-change.sh ;;
		*navy) sed -i -e "0,/^color1/ s/color1.*/color1='$\{colors.navy}'/" $SDIR/theme-change.sh ;;
		*pink) sed -i -e "0,/^color1/ s/color1.*/color1='$\{colors.pink}'/" $SDIR/theme-change.sh ;;
	esac
	$UPDATE
}

select_color2(){
	MENU2="$($position -p Dark_Color -columns 3 -lines 6 -width 40 <<<$colors)"
	case "$MENU2" in
		*black) sed -i -e "0,/^color2/ s/color2.*/color2='$\{colors.black}'/" $SDIR/theme-change.sh ;;
		*white) sed -i -e "0,/^color2/ s/color2.*/color2='$\{colors.white}'/" $SDIR/theme-change.sh ;;
		*red) sed -i -e "0,/^color2/ s/color2.*/color2='$\{colors.red}'/" $SDIR/theme-change.sh ;;
		*lime) sed -i -e "0,/^color2/ s/color2.*/color2='$\{colors.lime}'/" $SDIR/theme-change.sh ;;
		*blue) sed -i -e "0,/^color2/ s/color2.*/color2='$\{colors.blue}'/" $SDIR/theme-change.sh ;;
		*yellow) sed -i -e "0,/^color2/ s/color2.*/color2='$\{colors.yellow}'/" $SDIR/theme-change.sh ;;
		*aqua) sed -i -e "0,/^color2/ s/color2.*/color2='$\{colors.aqua}'/" $SDIR/theme-change.sh ;;
		*fuchsia) sed -i -e "0,/^color2/ s/color2.*/color2='$\{colors.fuchsia}'/" $SDIR/theme-change.sh ;;
		*silver) sed -i -e "0,/^color1/ s/color1.*/color2='$\{colors.silver}'/" $SDIR/theme-change.sh ;;
		*gray) sed -i -e "0,/^color2/ s/color2.*/color2='$\{colors.gray}'/" $SDIR/theme-change.sh ;;
		*maroon) sed -i -e "0,/^color2/ s/color2.*/color2='$\{colors.maroon}'/" $SDIR/theme-change.sh ;;
		*olive) sed -i -e "0,/^color2/ s/color2.*/color2='$\{colors.olive}'/" $SDIR/theme-change.sh ;;
		*green) sed -i -e "0,/^color2/ s/color2.*/color2='$\{colors.green}'/" $SDIR/theme-change.sh ;;
		*purple) sed -i -e "0,/^color2/ s/color2.*/color2='$\{colors.purple}'/" $SDIR/theme-change.sh ;;
		*teal) sed -i -e "0,/^color2/ s/color2.*/color2='$\{colors.teal}'/" $SDIR/theme-change.sh ;;
		*navy) sed -i -e "0,/^color2/ s/color2.*/color2='$\{colors.navy}'/" $SDIR/theme-change.sh ;;
		*pink) sed -i -e "0,/^color2/ s/color2.*/color2='$\{colors.pink}'/" $SDIR/theme-change.sh ;;
	esac
	$UPDATE
}

popup(){
	MENU1="$($position -columns 1 -width 20 -lines 3 <<<"👕 First_Color|👕 Second_Color")"
	case "$MENU1" in
		*First_Color) select_color1 ;;
		*Second_Color) select_color2 ;;
	esac
}

case "$1" in
	--show)
	popup ;;
	--switch)
	case "$CURRENT" in
	*lighter) MENU4=dark;select_theme ;;
	*dark) MENU4=darker; select_theme ;;
	*darker) MENU4=light; select_theme ;;
	*light) MENU4=lighter; select_theme ;;
	esac
	;;
	*)
	echo "👕"
esac

	
# -location 3 -columns 4  -width 50 -hide-scrollbar -line-padding 4 -padding 20 -lines 10


