#!/bin/bash 
for day in */
do
    cd $day;
    if [ -n "$(ls main.apl)" ]
    then
        echo -n $day | sed 's/\//: /';
        dyalogscript main.apl;
    fi;
    cd ..;
done
