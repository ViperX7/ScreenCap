#!/bin/sh

INPUT=$1
OUTPUT_FILE=$2
IN_FPS=$3
OUT_FPS=$4

for x in $(ls $INPUT) 
do
    diff $INPUT/$(printf %04d $(expr  $(echo $x |head -c -5) - 1)).png $INPUT/$x
    if [ $? -eq 0 ];then
        rm $INPUT/$(printf %04d $(expr  $(echo $x |head -c -5) - 1 )).png
    fi
done
