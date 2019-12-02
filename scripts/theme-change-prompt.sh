#!/bin/bash

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#  _                  _             _         _____                     #
# | |                | |           | |       |____ |                    #
# | | _____ _   _ ___| |_ _ __ ___ | | _____     / /                    #
# | |/ / _ \ | | / __| __| '__/ _ \| |/ / _ \    \ \                    #
# |   <  __/ |_| \__ \ |_| | | (_) |   <  __/.___/ /                    #
# |_|\_\___|\__, |___/\__|_|  \___/|_|\_\___|\____/                     #
#            __/ |                                                      #
#           |___/                                                       #
#                                                                       #
# Github: https://github.com/keystroke3                                 #
# Reddit: u/SiliconRaven                                                #
# Twitter: @SiliconRaven                                                #
# License: GPLv3 https://www.gnu.org/licenses/gpl-3.0.en.html           #
#                                                                       #
#                                                                       #
# Useful resources:                                                     #
# https://github.com/polybar/polybar-scripts                            #
# https://github.com/davatorium/rofi                                    #
# https://github.com/jordansissel/xdotool                               #
# https://github.com/dylanaraps/pywal                                   #
# https://www.gnu.org/software/sed/manual/sed.html                      #
#                                                                       #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #


SDIR="$HOME/.config/polybar/scripts"

# CURRENT=transparent1
# UPDATE takes the the current config and place it in theme-change.sh which will then modify
# the CURRENT value in this file after refreshing Polybar
CURRENT=transparent1
UPDATE="$SDIR/theme-change.sh $CURRENT" 

# Get the display dimensions and where pointer is.
eval "$(xdotool getmouselocation --shell)"
eval "$(xdotool getdisplaygeometry --shell)"

# Checks the postion of the mouse and determines where the popup should be.
# If the user's rofi theme has set dimensions and position, the user's configs are maintained
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
colors="  pywal_colors|👕 black|👕 white|👕 red|👕 lime|👕 blue|👕 yellow|👕 aqua|👕 fuchsia|👕 silver|👕 gray|👕 maroon|👕 olive|👕 green|👕 purple|👕 teal|👕 navy|👕 pink"
pywal_colors=" xcolor0| xcolor1| xcolor2| xcolor3| xcolor4| xcolor5| xcolor6| xcolor7| xcolor8| xcolor9 | xcolor10| xcolor11| xcolor12| xcolor13| xcolor14| xcolor15"

# This part sets a user specified Pywal color and makes it the first color.
select_pywal1(){
	MENU="$($position -p Pywal_Color -columns 3 -lines 6 -width 30 <<<$pywal_colors)"
	case "$MENU" in
		*red) sed -i -e "0,/^color1/ s/color1.*/color1='$\{colors.red}'/" $SDIR/theme-change.sh ;;
		*xcolor0) sed -i -e "0,/^color1/ s/color1.*/color1='$\{colors.xcolor0}'/" $SDIR/theme-change.sh ;;
		*xcolor1) sed -i -e "0,/^color1/ s/color1.*/color1='$\{colors.xcolor1}'/" $SDIR/theme-change.sh ;;
		*xcolor2) sed -i -e "0,/^color1/ s/color1.*/color1='$\{colors.xcolor2}'/" $SDIR/theme-change.sh ;;
		*xcolor3) sed -i -e "0,/^color1/ s/color1.*/color1='$\{colors.xcolor3}'/" $SDIR/theme-change.sh ;;
		*xcolor4) sed -i -e "0,/^color1/ s/color1.*/color1='$\{colors.xcolor4}'/" $SDIR/theme-change.sh ;;
		*xcolor5) sed -i -e "0,/^color1/ s/color1.*/color1='$\{colors.xcolor5}'/" $SDIR/theme-change.sh ;;
		*xcolor6) sed -i -e "0,/^color1/ s/color1.*/color1='$\{colors.xcolor6}'/" $SDIR/theme-change.sh ;;
		*xcolor7) sed -i -e "0,/^color1/ s/color1.*/color1='$\{colors.xcolor7}'/" $SDIR/theme-change.sh ;;
		*xcolor8) sed -i -e "0,/^color1/ s/color1.*/color1='$\{colors.xcolor8}'/" $SDIR/theme-change.sh ;;
		*xcolor9) sed -i -e "0,/^color1/ s/color1.*/color1='$\{colors.xcolor9}'/" $SDIR/theme-change.sh ;;
		*xcolor10) sed -i -e "0,/^color1/ s/color1.*/color1='$\{colors.xcolor10}'/" $SDIR/theme-change.sh ;;
		*xcolor11) sed -i -e "0,/^color1/ s/color1.*/color1='$\{colors.xcolor11}'/" $SDIR/theme-change.sh ;;
		*xcolor12) sed -i -e "0,/^color1/ s/color1.*/color1='$\{colors.xcolor12}'/" $SDIR/theme-change.sh ;;
		*xcolor13) sed -i -e "0,/^color1/ s/color1.*/color1='$\{colors.xcolor13}'/" $SDIR/theme-change.sh ;;
		*xcolor14) sed -i -e "0,/^color1/ s/color1.*/color1='$\{colors.xcolor14}'/" $SDIR/theme-change.sh ;;
		*xcolor15) sed -i -e "0,/^color1/ s/color1.*/color1='$\{colors.xcolor15}'/" $SDIR/theme-change.sh ;;		
	esac
	$UPDATE
}

# This does the same thing as select_pywal1 but with the second color
select_pywal2(){
	MENU="$($position -p Pywal_Color -columns 3 -lines 6 -width 30 <<<$pywal_colors)"
	case "$MENU" in
		*xcolor0) sed -i -e "0,/^color2/ s/color2.*/color2='$\{colors.xcolor0}'/" $SDIR/theme-change.sh ;;
		*xcolor1) sed -i -e "0,/^color2/ s/color2.*/color2='$\{colors.xcolor1}'/" $SDIR/theme-change.sh ;;
		*xcolor2) sed -i -e "0,/^color2/ s/color2.*/color2='$\{colors.xcolor2}'/" $SDIR/theme-change.sh ;;
		*xcolor3) sed -i -e "0,/^color2/ s/color2.*/color2='$\{colors.xcolor3}'/" $SDIR/theme-change.sh ;;
		*xcolor4) sed -i -e "0,/^color2/ s/color2.*/color2='$\{colors.xcolor4}'/" $SDIR/theme-change.sh ;;
		*xcolor5) sed -i -e "0,/^color2/ s/color2.*/color2='$\{colors.xcolor5}'/" $SDIR/theme-change.sh ;;
		*xcolor6) sed -i -e "0,/^color2/ s/color2.*/color2='$\{colors.xcolor6}'/" $SDIR/theme-change.sh ;;
		*xcolor7) sed -i -e "0,/^color2/ s/color2.*/color2='$\{colors.xcolor7}'/" $SDIR/theme-change.sh ;;
		*xcolor8) sed -i -e "0,/^color2/ s/color2.*/color2='$\{colors.xcolor8}'/" $SDIR/theme-change.sh ;;
		*xcolor9) sed -i -e "0,/^color2/ s/color2.*/color2='$\{colors.xcolor9}'/" $SDIR/theme-change.sh ;;
		*xcolor10) sed -i -e "0,/^color2/ s/color2.*/color2='$\{colors.xcolor10}'/" $SDIR/theme-change.sh ;;
		*xcolor11) sed -i -e "0,/^color2/ s/color2.*/color2='$\{colors.xcolor11}'/" $SDIR/theme-change.sh ;;
		*xcolor12) sed -i -e "0,/^color2/ s/color2.*/color2='$\{colors.xcolor12}'/" $SDIR/theme-change.sh ;;
		*xcolor13) sed -i -e "0,/^color2/ s/color2.*/color2='$\{colors.xcolor13}'/" $SDIR/theme-change.sh ;;
		*xcolor14) sed -i -e "0,/^color2/ s/color2.*/color2='$\{colors.xcolor14}'/" $SDIR/theme-change.sh ;;
		*xcolor15) sed -i -e "0,/^color2/ s/color2.*/color2='$\{colors.xcolor15}'/" $SDIR/theme-change.sh ;;		
	esac
	$UPDATE
}

# Same as the above but with prespecified colors
select_color1(){
	MENU="$($position -p Light_Color -columns 3 -lines 6 -width 30 <<<$colors)"
	case "$MENU" in
		*pywal_colors) select_pywal1 ;;
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
		*pink) echo $MENU3;sed -i -e "0,/^color1/ s/color1.*/color1='$\{colors.pink}'/" $SDIR/theme-change.sh ;;
	esac
	$UPDATE
}

select_color2(){
	MENU="$($position -p Dark_Color -columns 3 -lines 6 -width 30 <<<$colors)"
	case "$MENU" in
		*pywal_colors) select_pywal2 ;;
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


# Prompt for the user to choose.
popup(){
	MENU="$($position -columns 1 -width 20 -lines 3 <<<"👕 First_Color|👕 Second_Color")"
	case "$MENU" in
		*First_Color) select_color1 ;;
		*Second_Color) select_color2 ;;
	esac
}


# This part waits for instructions from the polybar module. When --show is supplied,
# it shows the selection menu. When --switch is supplied, it cycles through the varous
# configurations 
case "$1" in
	--show)
	popup ;;
	--switch)
	case "$CURRENT" in
	*white1) $SDIR/theme-change.sh white2 ;;
	*white2) $SDIR/theme-change.sh transparent1 ;;
	*transparent1) $SDIR/theme-change.sh transparent2 ;;
	*transparent2) $SDIR/theme-change.sh black1 ;;
	*black1) $SDIR/theme-change.sh black2 ;;
	*black2) $SDIR/theme-change.sh white1 ;;
	esac
	;;
	*) echo "running" ;;
esac


