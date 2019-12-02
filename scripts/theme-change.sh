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



PDIR="$HOME/.config/polybar/"
LAUNCH="polybar-msg cmd restart"

#These are the two colors to be alternated
color1='${colors.xcolor15}'
color2='${colors.black}'


white1(){
    sed -i -e "0,/^shade1/ s/shade1.*/shade1 = $color1/" $PDIR/bubbles.ini
    sed -i -e "0,/^shade2/ s/shade2.*/shade2 = $color2/" $PDIR/bubbles.ini
    sed -i -e "0,/^background/ s/background.*/background = $\{colors.white\}/" $PDIR/bubbles.ini
    sed -i -e "0,/^CURRENT/ s/CURRENT.*/CURRENT=white1/" $PDIR/scripts/theme-change-prompt.sh
}

white2(){
    sed -i -e "0,/^shade1/ s/shade1.*/shade1 = $color2/" $PDIR/bubbles.ini
    sed -i -e "0,/^shade2/ s/shade2.*/shade2 = $color1/" $PDIR/bubbles.ini
    sed -i -e "0,/^background/ s/background.*/background = $\{colors.white\}/" $PDIR/bubbles.ini
    sed -i -e "0,/^CURRENT/ s/CURRENT.*/CURRENT=white2/" $PDIR/scripts/theme-change-prompt.sh
}


transparent1(){
    sed -i -e "0,/^shade1/ s/shade1.*/shade1 = $color1/" $PDIR/bubbles.ini
    sed -i -e "0,/^shade2/ s/shade2.*/shade2 = $color2/" $PDIR/bubbles.ini
    sed -i -e "0,/^background/ s/background.*/background = $\{colors.transparent\}/" $PDIR/bubbles.ini
    sed -i -e "0,/^CURRENT/ s/CURRENT.*/CURRENT=transparent1/" $PDIR/scripts/theme-change-prompt.sh
}

transparent2(){
    sed -i -e "0,/^shade1/ s/shade1.*/shade1 = $color2/" $PDIR/bubbles.ini
    sed -i -e "0,/^shade2/ s/shade2.*/shade2 = $color1/" $PDIR/bubbles.ini
    sed -i -e "0,/^background/ s/background.*/background = $\{colors.transparent\}/" $PDIR/bubbles.ini
    sed -i -e "0,/^CURRENT/ s/CURRENT.*/CURRENT=transparent2/" $PDIR/scripts/theme-change-prompt.sh

}

black1(){
    sed -i -e "0,/^shade1/ s/shade1.*/shade1 = $color1/" $PDIR/bubbles.ini
    sed -i -e "0,/^shade2/ s/shade2.*/shade2 = $color2/" $PDIR/bubbles.ini
    sed -i -e "0,/^background/ s/background.*/background = $\{colors.black\}/" $PDIR/bubbles.ini
    sed -i -e "0,/^CURRENT/ s/CURRENT.*/CURRENT=black1/" $PDIR/scripts/theme-change-prompt.sh
}

black2(){
    sed -i -e "0,/^shade1/ s/shade1.*/shade1 = $color2/" $PDIR/bubbles.ini
    sed -i -e "0,/^shade2/ s/shade2.*/shade2 = $color1/" $PDIR/bubbles.ini
    sed -i -e "0,/^background/ s/background.*/background = $\{colors.black\}/" $PDIR/bubbles.ini
    sed -i -e "0,/^CURRENT/ s/CURRENT.*/CURRENT=black2/" $PDIR/scripts/theme-change-prompt.sh
}

if [[ $1 = "white1" ]]; then
    white1  
elif [[ $1 = "white2" ]]; then
    white2
elif [[ $1 = "transparent1" ]]; then
    transparent1
elif [[ $1 = "transparent2" ]]; then
    transparent2
elif [[ $1 = "black1" ]]; then
    black1
elif [[ $1 = "black2" ]]; then
    black2
else
echo "optins are:
-white1         -white2
-dark1          -dark2
-transparent1   -transparent2"
fi




# EOF
