#!/bin/bash
files=("total-up" "total-down" "prev-down" "prev-up")
for file in ${files[@]};do
    [ -f $file ] && : || echo "0" > $file
done

total_up=$(cat total-up)
total_down=$(cat total-down)
prev_down=$(cat prev-down)
prev_up=$(cat prev-up)

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
    interface=`ip route | grep -oPm1 "(?<=dev )[^ ]+"`
    declare -A bytes
    down_file=/sys/class/net/"$interface"/statistics/rx_bytes
    up_file=/sys/class/net/"$interface"/statistics/tx_bytes
    if [ -f $down_file ];then
        current_down=$(cat $down_file)
        current_up=$(cat $up_file)
        up_diff=$(( current_up-prev_up ))
        down_diff=$(( current_down-prev_down ))
        new_up=$(( total_up+up_diff ))
        new_down=$(( total_down+down_diff )) 
        echo $current_down > prev-down
        echo $current_up > prev-up
        echo $new_down > total-down
        echo $new_up > total-up
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
        calc
esac

