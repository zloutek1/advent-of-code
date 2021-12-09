#!/bin/bash

set -e

dev=true # example || input

if [[ $dev = true ]]; then
    input_filename=./example_input.txt
    output_filename=./functions/example.mcfunction
    sed -i 's/input:input/input:example/' ../make/functions/install.mcfunction
else
    input_filename=./input.txt
    output_filename=./functions/input.mcfunction
    sed -i 's/input:example/input:input/' ../make/functions/install.mcfunction
fi

rm ./functions/**

function str_to_mc() {
    # $1 - str
    ord=$(printf "%d" "'$char")
    local char=$1

    echo "summon minecraft:armor_stand $((x - 1)) $y 0 {"       \
        "Tags: [input, char],"                          \
        "CustomName:'{"                                 \
            "\"text\":\"\'$char\'\""                    \
        "}',"                                           \
        "CustomNameVisible: 1b,"                        \
        "NoGravity: 1b,"                                \
        "Small: 1b,"                                    \
        "Invisible: 1b,"                                \
        "ArmorItems: ["                                 \
            "{},"                                       \
            "{},"                                       \
            "{},"                                       \
            "{"                                         \
                "id: \"chest\","                        \
                "Count: 1b,"                            \
                "tag: {"                                \
                    "ascii: $ord"                       \
                "}"                                     \
            "}"                                         \
        "]"                                             \
    "}"
}

#length=$(wc -c < ${input_filename})
#for i in $(seq 0 16 $length); do
#    echo "forceload add $i 0 $((i+16)) 15" >> ./functions/allocate.mcfunction
#    echo "forceload remove $i 0 $((i+16)) 15" >> ./functions/free.mcfunction
#done

x=1
y=$(($(wc -l < ${input_filename}) + 5))
while IFS= read -r -N 1 char; do
    escaped=$char
    if [[ $char == $'\n' ]]; then
        escaped="\\\\n"
    fi
    if [[ $char == $' ' ]]; then
        escaped=":space:"
    fi
    str_to_mc $escaped >> ${output_filename}
    ((++x))
    if [[ $char == $'\n' ]]; then
        ((--y))
        ((x=1))
    fi
done < ${input_filename}
str_to_mc "EOF" >> ${output_filename}