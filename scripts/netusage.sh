#!/bin/bash
interface=`ip route | grep -oPm1 "(?<=dev )[^ ]+"`
declare -A bytes
down_file=/sys/class/net/"$interface"/statistics/rx_bytes
up_file=/sys/class/net/"$interface"/statistics/tx_bytes

total_up_file=$HOME/.config/polybar/scripts/total-up
total_down_file=$HOME/.config/polybar/scripts/total-down
prev_down_file=$HOME/.config/polybar/scripts/prev-down
prev_up_file=$HOME/.config/polybar/scripts/prev-up

files=("$total_up_file" "$total_down_file" "$prev_down_file" "$prev_up_file")
for file in ${files[@]};do
    [ -f $file ] && : || echo "0" > $file
done

total_up=$(cat $total_up_file) 
total_down=$(cat $total_down_file)
prev_down=$(cat $prev_down_file)
prev_up=$(cat $prev_up_file)

format() {
    if [ "$1" -eq 0 ] || [ "$1" -lt 1000 ]; then
        bytes="off"
    elif [ "$1" -lt 1000000 ]; then
        bytes="$(echo "scale=0;$1/1000" | bc -l ) KB"
    else
        bytes="$(echo "scale=1;$1/1000000" | bc -l ) MB"
    fi
    echo "$bytes"
}

calc(){

    if [ -f $down_file ];then
        current_down=$(cat $down_file)
        current_up=$(cat $up_file)
        up_diff=$(( current_up-prev_up ))
        down_diff=$(( current_down-prev_down ))
        new_up=$(( total_up+up_diff ))
        new_down=$(( total_down+down_diff )) 
        echo $current_down > $total_down_file
        echo $current_up > $prev_up_file
        echo $new_down > $total_down_file
        echo $new_up > $total_up_file
    else
        down=0
        up=0
    fi
}
case $1 in
    total)
        calc
        echo $(format $(( new_up+new_down ))) ;;
    split)
        calc
        echo $(format $new_down)/$(format $new_up) ;;
    *)
        echo "Download: $(cat $down_file)"
        echo "Upload: $(cat $up_file)"
esac

