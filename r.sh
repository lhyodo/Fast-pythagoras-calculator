
#!/bin/bash

#Author: Leo Hyodo
#Program name: Pythagoras Hypotenuse Calculation

#Purpose: script file to run the program files together.
#Clear any previously compiled outputs
rm *.o
rm *.lis
rm *.out

echo "compile driver.cpp using the g++ compiler standard 2020"
g++ -c -Wall -m64 -fno-pie -no-pie -std=c++20 -o driver.o driver.cpp

echo "Assemble hypotenuse.asm"
nasm -f elf64 -l hypotenuse.lis -o hypotenuse.o hypotenuse.asm

echo "Link object files using the g++ Linker standard 2020"
g++ -m64 -fno-pie -no-pie -std=c++20 -o final.out hypotenuse.o driver.o 

echo "Run the Pythagoras Program:"
./final.out

echo "Script file has terminated."

rm *.o
rm *.lis
rm *.out