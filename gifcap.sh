#!/bin/sh

OUTPUT_DIRECTORY=$1
FRAMERATE=$2
STARTUP_DELAY=$3

SCREENSHOT_DELAY=$(expr 100 \/ $FRAMERATE)

wait=$STARTUP_DELAY

delay(){
    if [ $wait != 0 ];then
        echo  Starting Recording in $wait
        wait=$(expr $wait - 1)
        sleep 1
        delay

    else
        sleep 1
    fi

}
num=1

gifcap()
{
    sleep $FRAMERATE
    file=$OUTPUT_DIRECTORY'/'$(python3 rename.py $num'.jpg')
    scrot $file -q 100
    num=$(expr $num + 1)
    gifcap
}

delay
gifcap
