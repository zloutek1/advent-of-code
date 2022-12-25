#!/bin/bash 
cd () { 
    command cd "$@" > /dev/null 
}

test () {
    day=$@;
    cd $day;
    if [ -n "$(ls main.apl)" ]
    then
        if ! [ -f 'example.ans.txt' ] || [ "$(cat 'example.ans.txt')" != "$(echo 'example.txt' | dyalogscript main.apl)" ];
        then 
            echo $day': example.txt' | sed 's/\.\///' | sed 's/\///';
            echo 'example.txt' | dyalogscript main.apl | sed 's/^/      /'
            exit
        fi;


        if ! [ -f 'input.ans.txt' ] || [ "$(cat 'input.ans.txt')" != "$(echo 'input.txt' | dyalogscript main.apl)" ];
        then 
            echo $day': input.txt' | sed 's/\.\///' | sed 's/\///';
            echo 'input.txt' | dyalogscript main.apl | sed 's/^/      /'
            exit
        fi;

        echo $day': **' | sed 's/\.\///' | sed 's/\///';
    fi;
    cd ..;
}

if [ $# = 1 ];
then
    test $1;
else
    for day in $(ls -dv */)
    do
        test $day;
    done
fi;
