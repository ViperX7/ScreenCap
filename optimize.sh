#!/bin/sh

INPUT=$1

for x in $(ls $INPUT) 
do
    diff $INPUT/$(printf %04d $(expr  $(echo $x |head -c -5) - 1)).png $INPUT/$x 1>/dev/null
    if [ $? -eq 0 ];then
        echo Removing $INPUT/$(printf %04d $(expr  $(echo $x |head -c -5) - 1 )).png
        rm $INPUT/$(printf %04d $(expr  $(echo $x |head -c -5) - 1 )).png 2>/dev/null
    fi
done


echo Realigning and preparing for compilation
if [ $2 -eq '']
then
    i=1
    for x in $(ls $INPUT/)
    do
    mv $INPUT/$x $INPUT/$(printf %04d $i).png
    i=$(expr $i + 1)
    done
fi
