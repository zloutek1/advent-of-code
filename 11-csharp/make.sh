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

(cd $DIR && dotnet run \
         && rm -r bin obj)
