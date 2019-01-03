#/!/bin/sh

#backup.sh
#Authors: Thomas Nemeh/Lukas Griffin. September 24, 2018.
#Description: copies files given as arguments into given directory if the file does not exist in the directory of if the file has a newer timestamp than its clone in the directory. 

#get directory to copy into supplied as first argument
dir=$1

shift

#loop through arguments and copy each file into the directory if appropriate
while [ "$1" != "" ]; do
    if [ -e "${dir}/${1}" ] ;then
	if [ "$1" -nt "${dir}/${1}" ] ;then
	    cp -f "$1" "${dir}/${1}" 
	fi
    else
	mv "$1" "${dir}"
    fi
    shift
done
    
