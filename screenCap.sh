#!/bin/sh


# Strings

help='usage: imgtool [-h] [-o output] [-f FRAMERATE] [-d DELAY]
\n
\noptional arguments:
\n
\n\t  -o PATH, --out path\t\t\t            Output Directory where screenshots will be saved
\n\t  -f FRAMERATE, --framerate FRAMERATE\t            Number of seconds to wait between two frames
\n\t  -d DELAY , --dekay DELAY\t\t           Delay before recording starts
\n\t  -h, --help\t\t\t\t           Show this help message and exit'

title="GIFCap"

banner()
{
BANNER="####################################\n\t\t$title\n####################################"
}

# Exit Function
    quit()
    {
        return $@
        exit
    }


# DEFAULT PARAMETERES


OUTPUT_DIRECTORY=$(date +%F-%H_%M_%s)
FRAMERATE=0.1
DELAY=5


# Command Line Argument Parsing


while [ $# -gt 0 ]
do
    key=$1
    case $key in
        -o|--out)
            OUTPUT_DIRECTORY=$2
            shift
            shift
            ;;
        -f|--framerate)
            FRAMERATE=$2
            shift
            shift
            ;;
        -d|--delay)
            DELAY=$2
            shift
            shift
            ;;
       -h|--help)
            echo -e $help
            shift
            ;;
        *)    # unknown option
            echo Unknown parameter $key
            echo -e $help
            quit 2
            shift # past argument
            ;;
    esac
done




delay(){
    if [ $DELAY != 0 ];then
        echo  -ne "\r$(tput setaf 1)Recording in "$(tput setaf 3)"$DELAY"
        DELAY=$(expr $DELAY - 1)
        sleep 1
        delay

    else
        echo  -e "\r$(tput setaf 2)Recording Started                          "
        sleep 1
    fi

}
num=1

dir_chk()
{
    if [ -e $1 ]
    then
        echo Writing Files to $OUTPUT_DIRECTORY
    else
        echo -n "$1 not found trying to creating $1"
        mkdir -p $1
        if [ -e $1 ]
        then
            echo $(tput setaf 2) Sucessed $(tput sgr0)
        else
            echo $(tput setaf 1) Failed $(tput sgr0)
            echo exitting
            exit
        fi
    fi
}



gifcap()
{
    sleep $FRAMERATE
    file=$OUTPUT_DIRECTORY'/'$(printf %04d $num)'.png'
    scrot $file -q 100
    num=$(expr $num + 1)
    gifcap
}



execute()
{
    banner
    echo -e $BANNER
    dir_chk $OUTPUT_DIRECTORY
    delay
    gifcap


}


execute
