#!/bin/bash

set -e

mkcd() {
    mkdir $1
    cd $1
}

tree_minimum() {
    while [ -d left ]; do
        cd left
    done
}

tree_maximum() {
    while [ -d right ]; do
        cd right
    done
}

tree_successor() {
    if [ -d right ]; then
        cd right
        tree_minimum
        return
    fi
    while [ $(basename $(pwd)) != number* ] && [ $(basename $(pwd)) = "right" ]; do
        cd ..
    done
    cd ..
}

successor() {
    tree_successor
    if [ $(basename $(pwd)) != numbers ]; then
        tree_successor
        if [ $(basename $(pwd)) != number* ]; then
            echo $(pwd)
        else
            echo "none"
        fi
    else
        echo "none"
    fi
}

tree_predecessor() {
    if [ -d left ]; then
        cd left
        tree_maximum
    else
        while [[ $(basename $(pwd)) != number* ]] && [ $(basename $(pwd)) = "left" ]; do
            cd ..
        done
        cd ..
    fi
}

predecessor() {
    tree_predecessor
    if [ $(basename $(pwd)) != numbers ]; then
        tree_predecessor
        if [ $(basename $(pwd)) != numbers ]; then
            echo $(pwd)
        else
            echo "none"
        fi
    else
        echo "none"
    fi
}

is_leaf() {
    if [ ! -d left ] && [ ! -d right ]; then
        echo true
    else
        echo false
    fi
}


reduce() {
    while [ true ]; do
        changed=$(try_to_explode 0)
        if [ $changed = true ]; then
            continue
        fi

        changed=$(try_to_split)
        if [ $changed = false ]; then
            break
        fi
    done
}

try_to_explode() {
    local depth=$1
    if [ $(is_leaf) = true ]; then
        echo false
    elif [ $depth -ge 4 ]; then
        explode
        echo true
    else
        depth=$(($depth + 1))
        cd left
        changed=$(try_to_explode $depth)
        if [ $changed = true ]; then
            echo true
        else
            cd ../right
            changed=$(try_to_explode $depth)
            if [ $changed = true ]; then
                echo true
            else
                echo false
            fi
        fi
        cd ..
    fi
}

explode() {
    pred=$(cd left; predecessor)
    if [ $pred != "none" ]; then
        val=$(ls left)
        pred_val=$(ls $pred)
        new_val=$(($pred_val + $val))
        mv -n "$pred/$pred_val" "$pred/$new_val"
    fi

    succ=$(cd right; successor)
    if [ $succ != "none" ]; then
        val=$(ls right)
        succ_val=$(ls $succ)
        new_val=$(($succ_val + $val))
        mv -n "$succ/$succ_val" "$succ/$new_val"
    fi

    rm -r left right
    touch 0
}

try_to_split() {
    if [ $(is_leaf) = true ]; then
        if [ $(ls) -ge 10 ]; then
            split
            echo true
        else
            echo false
        fi
    else
        cd left
        changed=$(try_to_split)
        if [ $changed = true ]; then
            echo true
        else
            cd ../right
            changed=$(try_to_split)
            if [ $changed = true ]; then
                echo true
            else
                echo false
            fi
        fi
        cd ..
    fi
}

split() {
    value=$(ls)
    left=$(($value / 2))
    right=$((($value + 1) / 2))

    rm $value
    mkdir left right
    echo $left > left/$left
    echo $right > right/$right
}

add() {
    mkdir -p result
    mv $1 result/left
    mv $2 result/right
    $(cd result; reduce)
}

addmany() {
    add $(ls | head -1) $(ls | head -2 | tail -1)
    for number in number*; do
        mv result numberXXX
        add numberXXX $number
    done
}

magnitude() {
    if [ $(is_leaf) = true ]; then
        echo $(ls)
    else
        left=$(cd left; magnitude)
        right=$(cd right; magnitude)
        echo $((3 * $left + 2 * $right))
    fi
}


part1() {
    addmany
    echo $(cd result; magnitude)
}



parse_number() {
    local number=$1
    local char=${number:0:1}
    if [ -z $char ]; then
        cd ..
    elif [ "$char" = "[" ]; then
        if [ "$(ls -A $pwd)" ]; then
            mkcd "right"
        else
            mkcd "left"
        fi
        parse_number ${number:1}
    elif [ "$char" = "," ]; then
        parse_number ${number:1}
    elif [ "$char" = "]" ]; then
        cd ..
        parse_number ${number:1}
    else
        if [ "$(ls -A $pwd)" ]; then
            mkdir right
            echo "${number:0:1}" > "right/${number:0:1}"
        else
            mkdir left
            echo "${number:0:1}" > "left/${number:0:1}"
        fi
        parse_number ${number:1}
    fi
}

parse_line() {
    local n=$(printf "%02d" $1)
    local line=$2
    mkcd "number$n"
    parse_number ${line:1:${#line}-2}
}

parse_file() {
    local filename=$1

    rm -rf numbers
    mkcd numbers

    n=1
    while read -r line; do
        parse_line $n $line
        n=$((n+1))
    done < "$path/$filename"
    parse_line $n $line
}

path=$(pwd)
parse_file "example_input.txt"

part1

cd ..
rm -r numbers