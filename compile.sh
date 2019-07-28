#!/bin/sh

INPUT=$1
OUTPUT_FILE=$2
IN_FPS=$3
OUT_FPS=$4

ffmpeg -y -framerate $IN_FPS -i $INPUT%04d.png -c:v libx264 -r $OUT_FPS $OUTPUT_FILE
