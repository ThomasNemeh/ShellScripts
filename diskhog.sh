#/!/bin/sh

#diskhog.sh
#Authors: Thomas Nemeh/Lukas Griffin. September 24, 2018.
#Description: prints the x largest files in the directory, where x is determined by user input, or 5 if nothing entered.

numLines=5


#allow user to set number of l;nes
if [ $1 != "" ]; then
    numLines=$1
fi

echo "Size of the 5 largest files in this directory, in kilobytes:"

#get sices of files
du -h -a -k --exclude="./*/*" < $PWD > temp.txt

#sort by size
echo "$(sort -n -r temp.txt)" > temp.txt

#remove the size of the current directory
echo "$(sed '1d' temp.txt)" > temp.txt

#only list numLines files
echo "$(head -n $numLines temp.txt)" > temp.txt

cat temp.txt
























