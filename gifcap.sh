#!/bin/sh

OUTPUT_DIRECTORY=$1
FRAMERATE=$2
STARTUP_DELAY=$3

SCREENSHOT_DELAY=$(expr 100 \/ $FRAMERATE)

wait=$STARTUP_DELAY

delay(){
    if [ $wait != 0 ];then
        echo  -ne "\r$(tput setaf 1)Recording in "$(tput setaf 3)"$wait"
        wait=$(expr $wait - 1)
        sleep 1
        delay

    else
        echo  -e "\r$(tput setaf 2)Recording Started                          "
        sleep 1
    fi

}
num=1

if [ -e $OUTPUT_DIRECTORY ]
then
    echo Writing Files to $OUTPUT_DIRECTORY
else
    echo -n "$OUTPUT_DIRECTORY not found trying to create one"
    mkdir -p $OUTPUT_DIRECTORY
    if [ -e $OUTPUT_DIRECTORY ]
    then
        echo $(tput setaf 2) Sucessed $(tput sgr0)
    else
        echo $(tput setaf 1) Failed $(tput sgr0)
        echo exitting
        exit
    fi
fi

gifcap()
{
    sleep $FRAMERATE
    file=$OUTPUT_DIRECTORY'/'$(python3 rename.py $num'.png')
    scrot $file -q 100
    num=$(expr $num + 1)
    gifcap
}

delay
gifcap
