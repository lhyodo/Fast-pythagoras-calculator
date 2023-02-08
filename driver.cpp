//****************************************************************************************************************************
//Program name: "Pythagoras Hypotenuse Calculator".  This program takes 2 legs of a triangle and calculates the hypotenuse.  *
//The input and calculations are done in X86, and the hypotenuse is returned to C++ as a floating point value.               *
//Copyright (C) 2023  Leo Hyodo                                                                *
//This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
//version 3 as published by the Free Software Foundation.                                                                    *
//This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
//warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
//A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                           *
//****************************************************************************************************************************




//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
//Author information
//  Author name: Leo Hyodo
//  Author email: lhyodo@csu.fullerton.edu
//
//Program information
//  Program name: Pythagoras Hypotenuse Calculator
//  Programming languages: Main function in C++; input receiving and calculation function in X86-64
//  Date program began: 2023-Jan-25
//  Date of last update: 2023-Feb-02
//  Comments reorganized: 2023-Feb-02
//  Files in the program: driver.cpp, hypotenuse.asm, r.sh
//
//Purpose
//  The intent of this program is to demonstrate knowledge of assembly programming by creating a program that print messages, 
//  receives input, rejects invalid input, performs various calculations, and returns a floating point value back to C++.

//This file
//  File name: driver.cpp
//  Language: C++
//  Max page width: 132 columns
//  Optimal print specification: 7 point font, monospace, 133 columns, 8½x11 paper
//  Compile: g++ -c -Wall -m64 -fno-pie -no-pie -std=c++20 -o driver.o driver.cpp
//  Link: g++ -m64 -fno-pie -no-pie -std=c++20 -o final.out hypotenuse.o driver.o 
//
//Execution: ./final.out
//
//===== Begin code area ============================================================================================================


#include <stdio.h>
#include <stdint.h>
#include <time.h>
#include <sys/time.h>
#include <stdlib.h>
#include <iostream>

extern "C" double hypotenuse();

int main(int argc, char *argv[])
{
    std::cout << "Welcome to right triangles programmed by Leo Hyodo" << std::endl;
    std::cout << "Please contact me at lhyodo@csu.fullerton.edu if you need assistance." << std::endl;
    double answer = 0.0;
    answer = hypotenuse();
    std::cout.precision(12);
    std::cout << "The main file has received this number: " << std::fixed << answer << ", and will keep it for now." << std::endl;
    std::cout << "Program is now ending. A zero will be sent to your operating system. Good bye" << std::endl;
    return 0;
}