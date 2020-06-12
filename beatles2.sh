#!/bin/bash
function longest_word_in_song {
text=`cat "$1" | tail -n +2 | tr -cs 'A-Za-z' ' '`
max_len=0;
for word in $text; do
    len=${#word}
    if (( len > max_len ))
        then
            max_len=$len
            longest=$word
    fi
done
}

function longest_word_in_catalog {
    max_word=$(for i in $1/*.txt; do
    longest_word_in_song $i
    echo -e "$max_len\t$longest\t`cat "./$i" | head -n1`"
    done | cat | sort -h | tail -n -1 | cat )

    echo The longest word is `echo "$max_word" | cut -f1 ` letters long: \""`echo "$max_word" | cut -f2`\"" in \""`echo "$max_word" | cut -f3`\"". 
}   

function longest_song_in_catalog {
    max_song=$(for i in $1/*.txt; do
    echo -e "`cat "$i" | tail -n +2 | wc -w`\t`cat "./$i" | head -n1`"
    done | sort -h | tail -n -1
    )
    echo The longest Beatles song is \""`echo "$max_song" | cut -f2`\"" with "`echo "$max_song" | cut -f1`" words.
}

function shortest_song_in_catalog {
    min_song=$(for i in $1/*.txt; do
    echo -e "`cat "$i" | tail -n +2 | wc -w`\t`cat "./$i" | head -n1`"
    done | sort -h | head -1
    )
    echo The shortest Beatles song is \""`echo "$min_song" | cut -f2`\"" with "`echo "$min_song" | cut -f1`" words.
}

function most_frequent_beginning {
    freq_word=$(for i in $1/*.txt; do
    echo -e "`cat "$i"|tail -n +2|cut -d' ' -f1`"
    done
    )
    res=`echo "$freq_word" | tr A-Z a-z | tr -s " " "\n" | sort | uniq -c | sort -h |tail -n -1 `
    echo -e The most frequent word in the beginning of line is \""`echo $res | cut -d" " -f2`\"" and which appears `echo $res | cut -d" " -f1` times 
}

function usage {
    echo "Usage: ./beatles2.sh <beatles.lyrics-path>"
}

if [[ -z "$1" ]]
    then    
        usage $1
elif [[ ! -d "$1" ]]
    then
        usage $1
    else
        longest_song_in_catalog "$1"
        shortest_song_in_catalog "$1"
        longest_word_in_catalog "$1"
        most_frequent_beginning "$1"
fi
