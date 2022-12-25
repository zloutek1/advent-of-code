#!/bin/sh

while getopts "C:" opt
do
   case "$opt" in
      C ) CD="$OPTARG" ;;
      ? ) exit 1 ;;
   esac
done

DIR=$(pwd)
if [ ! -z "$CD" ]
then
    DIR=$CD
fi

(cd $DIR && dart compile exe main.dart \
         && ./main.exe \
         && rm -f ./main.exe)
