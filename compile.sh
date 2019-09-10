#!/bin/sh

# Strings

help='usage: ./compile [-h] [-i input_directory] [-o output] [-f FRAMERATE]
\n
\noptional arguments:
\n
\n\t  -i PATH, --input PATH\t\t\t            Input Directory Containing all the screenshots to be compiled
\n\t  -o PATH, --output PATH\t\t\t           Output filename
\n\t  -f FRAMERATE, --framerate FRAMERATE\t            Framerate used to capture screenshots default 10
\n\t  -h, --help\t\t\t\t           Show this help message and exit'

# Exit Function
    quit()
    {
        return $@
        exit
    }


# Default Arguments

FRAMERATE=10
IN_FPS=$FRAMERATE
OUT_FPS=$FRAMERATE


# Command Line Argument Parsing


while [ $# -gt 0 ]
do
    key=$1
    case $key in
        -o|--out)
            OUTPUT_FILE=$2
            shift
            shift
            ;;
        -f|--framerate)
            IN_FPS=$2
            OUT_FPS=$2
            shift
            shift
            ;;
        -fin|--framerate_input)
            IN_FPS=$2
            shift
            shift
            ;;
        -fout|--framerate_output)
            OUT_FPS=$2
            shift
            shift
            ;;
        -i|--input)
            INPUT=$2
            INPUT_DIR=$INPUT%04d.png
            shift
            shift
            ;;
       -h|--help)
            echo -e $help
            shift
            quit
            ;;
        *)    # unknown option
            echo Unknown parameter $key
            echo -e $help
            quit 2
            shift # past argument
            ;;
    esac
done



ffmpeg -y -framerate $IN_FPS -i $INPUT_DIR -c:v libx264 -r $OUT_FPS $OUTPUT_FILE
