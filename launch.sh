killall -q polybar

polybar --reload main -c ~/Carousel/config.ini &
polybar --reload bottom -c ~/Carousel/config.ini &
polybar --reload main -c ~/Carousel/config-hdmi.ini &

