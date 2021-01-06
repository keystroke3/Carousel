# killall -q polybar
# if type "xrandr" > /dev/null; then
#   for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
#     MONITOR=$m
#     polybar --reload main -c ~/Carousel/config.ini &
#     polybar --reload bottom -c ~/Carousel/config.ini &
#   done
# fi
killall -q polybar

polybar --reload main -c ~/Carousel/config.ini &
polybar --reload bottom -c ~/Carousel/config.ini &
polybar --reload main -c ~/Carousel/config-hdmi.ini &
polybar --reload bottom -c ~/Carousel/config-hdmi.ini &
