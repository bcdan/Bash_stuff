#!/bin/bash
function get_album_info
{
cut -f2,3 beatles_songs.info.txt | sort | uniq
}

function get_album_songs
{
read line
if grep -h $line$ beatles_songs.info.txt|cut -f1 ; then
	echo -e  "\nfinished searching" 
else
	echo "it's not here"
fi
}

get_album_info
get_album_songs
