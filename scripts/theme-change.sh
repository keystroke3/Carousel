#!/bin/bash

# sed "/foo/{s/foo/bar/1;q}" file

PDIR="$HOME/.config/polybar/"
LAUNCH="polybar-msg cmd restart"

color1='${colors.pink}'
color2='${colors.black}'

lighter(){
    sed -i -e "0,/^shade1/ s/shade1.*/shade1 = $color1/" $PDIR/bubbles.ini
    sed -i -e "0,/^shade2/ s/shade2.*/shade2 = $color2/" $PDIR/bubbles.ini
    sed -i -e "0,/^background/ s/background.*/background = $\{colors.white\}/" $PDIR/bubbles.ini
    sed -i -e "0,/^CURRENT/ s/CURRENT.*/CURRENT=lighter/" $PDIR/scripts/theme-change-prompt.sh
}

light(){
    sed -i -e "0,/^shade1/ s/shade1.*/shade1 = $color1/" $PDIR/bubbles.ini
    sed -i -e "0,/^shade2/ s/shade2.*/shade2 = $color2/" $PDIR/bubbles.ini
    sed -i -e "0,/^background/ s/background.*/background = $\{colors.transparent\}/" $PDIR/bubbles.ini
    sed -i -e "0,/^CURRENT/ s/CURRENT.*/CURRENT=light/" $PDIR/scripts/theme-change-prompt.sh
}

dark(){
    sed -i -e "0,/^shade1/ s/shade1.*/shade1 = $color2/" $PDIR/bubbles.ini
    sed -i -e "0,/^shade2/ s/shade2.*/shade2 = $color1/" $PDIR/bubbles.ini
    sed -i -e "0,/^background/ s/background.*/background = $\{colors.transparent\}/" $PDIR/bubbles.ini
    sed -i -e "0,/^CURRENT/ s/CURRENT.*/CURRENT=dark/" $PDIR/scripts/theme-change-prompt.sh

}

darker(){
    sed -i -e "0,/^shade1/ s/shade1.*/shade1 = $color1/" $PDIR/bubbles.ini
    sed -i -e "0,/^shade2/ s/shade2.*/shade2 = $color2/" $PDIR/bubbles.ini
    sed -i -e "0,/^background/ s/background.*/background = $\{colors.black\}/" $PDIR/bubbles.ini
    sed -i -e "0,/^CURRENT/ s/CURRENT.*/CURRENT=darker/" $PDIR/scripts/theme-change-prompt.sh
}

if [[ $1 = "dark" ]]; then
    dark   
elif [[ $1 = "light" ]]; then
    light
elif [[ $1 = "darker" ]]; then
    darker
elif [[ $1 = "lighter" ]]; then
    lighter
else
echo "optins are:
-dark   -darker
-light  -lighter"
fi
