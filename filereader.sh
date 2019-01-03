#/usr/bin/sh

#filereader.sh
#Authors: Thomas Nemeh/Lucas Griffin
#Description: takes a file with links and outputs those that are not valid. Tests if second argument is a valid HTML file according to the W3C validator.

#loop through file and outputs links that are not valid.
while read -r line
do
    {
	wget $line
    } &> /dev/null
    if [ $? != 0 ] ;then
	echo "Not found: $line"
    fi
done < "$1"

#if there is a second argument, tests if it is a valid HTML file
if [ $2 != "" ]; then

   echo $2 > temp.txt

   #put website name into valid format for validator
   website="$(sed -r 's/[/]+/%2F/g' temp.txt)"

   valid=0

   rm temp.txt

   #test whether website passes validator test
   wget -qO- "https://validator.w3.org/check?uri=http%3A%2F%2F$website%2F&charset=(detect+automatically)&doctype=Inline&group=0" | grep -q "successfully checked" && valid=1

   if [ $valid = 1 ]; then
      echo "$2 is a valid HTML file."
   else
      echo "$2 is not a valid HTML file."
   fi
 fi


