#/!/bin/sh

#gradeit.sh
#Authors: Thomas Nemeh/Lukas Griffin. September 24, 2018.
#Description: Compares a student labs, called student-diamond and student-rot128 to prof's versions, called diamond and rot128.

#Tests for diamond

#Deletes text and trailing whitespace from output of diamond program and puts just the actual diamond into a file
create_diamond () {
    echo $1 | ./$2  > $3
    echo "$(cut -d ':' -f 2 $3)" > $3
    echo "$(sed '1d' $3)" > $3
    if [ $4 -eq 1 ]; then
	 echo "$(sed '1s/^.//' $3)" > $3
    fi
    echo "$(sed 's/[ \t]*$//' $3)" > $3   
}

TEST=1

#test that the outputs are both empty given a negative number
create_diamond -1 ./diamond file1.txt 1
create_diamond -1 ./student-diamond file2.txt 0

if [ "$(diff file1.txt file2.txt)" != "" ]; then
    TEST=0
    echo "The student's diamond prints something when a negative number is entered."
fi

#test that the outputs are both empty given 0
create_diamond 0 ./diamond file1.txt 1
create_diamond 0 ./student-diamond file2.txt 0

if [ "$(diff file1.txt file2.txt)" != "" ]; then
    TEST=0
    echo "The student's diamond prints something with a 0 is entered."
fi

#test the diamonds are the same with a single star
create_diamond 1 ./diamond file1.txt 1
create_diamond 1 ./student-diamond file2.txt 0

if [ "$(diff file1.txt file2.txt)" != "" ]; then
    TEST=0
    echo "The student's program doesn't work given a 1."
fi

#test that the diamonds are the same given an even number
create_diamond 30 ./diamond file1.txt 1
create_diamond 30 ./student-diamond file2.txt 0

if [ "$(diff file1.txt file2.txt)" != "" ]; then
    TEST=0
    echo "The student's program doesn't work given an even number."
fi

#test that the diamons are the same given an odd number
create_diamond 55 ./diamond file1.txt 1
create_diamond 55 ./student-diamond file2.txt 0

if [ "$(diff file1.txt file2.txt)" != "" ]; then
    TEST=0
    echo "The student's program doesn't work given an odd number." 
fi

#Did all the tests pass?

if [ $TEST = 1 ]; then
    echo "The student's diamond recieves an A+.\n"
else
    echo "The student's diamond recieves an F.\n"
fi

#Tests for rot128

#test that lower case letters and numbers are encrypted the same way
echo "abcdefghijklmnopqrstuvwxyz1234567890" | ./rot128 > file1.txt
echo "abcdefghijklmnopqrstuvwxyz1234567890" | ./student-rot128 > file2.txt

#test that upper case letters and special characters are encrypted the same way
echo "ABCDEFGHIJKLMNOPQRSTUVWXYZ!@#$%^&*()_+-=,./<>?;':" | ./rot128 >> file1.txt
echo "ABCDEFGHIJKLMNOPQRSTUVWXYZ!@#$%^&*()_+-=,./<>?;':" | ./student-rot128 >> file2.txt

if [ "$(diff file1.txt file2.txt)" = "" ]; then
    echo "The student's rot-128 program recieves an A+."
else
    echo "The student's rot-128 program recieves an F."
fi

rm file1.txt
rm file2.txt
