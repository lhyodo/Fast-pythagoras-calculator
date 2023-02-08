;****************************************************************************************************************************
;Program name: "Pythagoras Hypotenuse Calculator".  This program takes 2 legs of a triangle and calculates the hypotenuse.  *
;The input and calculations are done in X86, and the hypotenuse is returned to C++ as a floating point value.               *
;Copyright (C) 2023  Leo Hyodo                                                                *
;This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
;version 3 as published by the Free Software Foundation.                                                                    *
;This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
;warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
;A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                           *
;****************************************************************************************************************************



;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7**

;Author information
;  Author name: Leo Hyodo
;  Author email: lhyodo@csu.fullerton.edu
;
;Program information
;  Program name: Pythagoras Hypotenuse Calculator
;  Programming languages: Main function in C++; input receiving and calculation in X86-64
;  Date program began: 2023-Jan-25
;  Date of last update: 2023-Feb-02
;  Comments reorganized: 2023-Feb-02
;  Files in the program: driver.cpp, hypotenuse.asm, r.sh
;
;Purpose
;  The intent of this program is to demonstrate knowledge of assembly programming by creating a program that print messages, 
;  receives input, rejects invalid input, performs various calculations, and returns a floating point value back to C++.
;
;This file
;  File name: hypotenuse.asm
;  Language: X86-64
;  Syntax: Intel
;  Max page width: 172 columns
;  Optimal print specification: Landscape, 7-point font, monospace, 172 columns, 8½x11 paper
;  Assemble: nasm -f elf64 -l hypotenuse.lis -o hypotenuse.o hypotenuse.asm
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7**
;
;
;Project information
;  Project files: driver.cpp, hypotenuse.asm, r.sh
;  Status: Available for public review.
;
;Translator information
;  Linux: nasm -f elf64 -l hypotenuse.lis -o hypotenuse.o hypotenuse.asm
;
;References and credits
;  Jorgensen, x86-64 Assembly Language Programming with Ubuntu
;
;Format information
;  Page width: 172 columns
;  Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
;
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7**
;
;===== Begin code area ====================================================================================================================================================



extern printf
extern scanf
global hypotenuse

;===== Declarations=========================================================================================================================================================
segment .data
brief db "This program will compute the hypotenuse given two sides of a triangle.",10, 0 ;10 is newline, 0 is nullchar
prompt db "Please enter the length of 2 sides separated by whitespace, followed by enter.",10,0

one_float_format db "%lf",0
three_float_format db "%lf %lf %lf", 0

response db "You entered %1.6lf and %1.6lf",10,0
result db "The length of the hypotenuse is %1.6lf",10,0
ending db "Returning value %1.6lf",10,0

invalid_message db "Invalid input. Re-enter 2 sides separated by whitespace, followed by enter.",10,0

zero dq 0.0

segment .bss

segment .text

hypotenuse: ; RENAME THIS TO THE NAME OF YOUR MODULE/FUNCTION THAT YOU ARE WRITING

;Prolog ===== Insurance for any caller of this assembly module ========================================================
;Any future program calling this module that the data in the caller's GPRs will not be modified.
push rbp
mov  rbp,rsp
push rdi                                                    ;Backup rdi
push rsi                                                    ;Backup rsi
push rdx                                                    ;Backup rdx
push rcx                                                    ;Backup rcx
push r8                                                     ;Backup r8
push r9                                                     ;Backup r9
push r10                                                    ;Backup r10
push r11                                                    ;Backup r11
push r12                                                    ;Backup r12
push r13                                                    ;Backup r13
push r14                                                    ;Backup r14
push r15                                                    ;Backup r15
push rbx                                                    ;Backup rbx
pushf                                                       ;Backup rflags

;block to show program brief
mov rax, 0
mov rdi, brief
call printf

;block to prompt enter of 2 sides
mov rax, 0
mov rdi, prompt
call printf

;block scanf float1, store in xmm15
mov rax, 0
mov rdi, one_float_format
push qword 0
push qword 0
mov rsi, rsp        ;rsi points to dummy value on the stack
call scanf          ;new value is placed in the location that rsi points to
movsd xmm15, [rsp]  ;xmm15 holds first float
pop rax
pop rax

;block scanf float2, store in xmm14
mov rax, 0
mov rdi, one_float_format
push qword 0
push qword 0
mov rsi, rsp        ;rsi points to dummy value on the stack
call scanf          ;new value is placed in the location that rsi points to
movsd xmm14, [rsp]  ;xmm14 holds second float
pop rax
pop rax

;block printf float1 float2
mov rax, 2
mov rdi, response
movsd xmm0, xmm15
movsd xmm1, xmm14
call printf

;block to compare both floats to 0, if any negative prompt re-enter loop
ucomisd xmm15, qword [zero]
jb loop
ucomisd xmm14, qword [zero]
jb loop
jmp calc


;=====beginning of loop=====
loop:
;block printf invalid input detected
mov rax, 2
mov rdi, invalid_message
movsd xmm0, xmm15
movsd xmm1, xmm14
call printf

;block scanf float1
mov rax, 0
mov rdi, one_float_format
push qword 0
push qword 0
mov rsi, rsp        ;rsi points to dummy value on the stack
call scanf          ;new value is placed in the location that rsi points to
movsd xmm15, [rsp]  ;xmm15 holds first float
pop rax
pop rax

;block scanf float2
mov rax, 0
mov rdi, one_float_format
push qword 0
push qword 0
mov rsi, rsp        ;rsi points to dummy value on the stack
call scanf          ;new value is placed in the location that rsi points to
movsd xmm14, [rsp]  ;xmm14 holds second float
pop rax
pop rax

;block printf float1 float2
mov rax, 2
mov rdi, response
movsd xmm0, xmm15
movsd xmm1, xmm14
call printf

;block conditional loop
ucomisd xmm15, qword [zero] ;compare float1 to 0
jb loop                     ;if float1 is less than 0, loop
ucomisd xmm14, qword [zero] 
jb loop                     ;if float2 is less than 0, loop
jmp calc
;=====end of loop=====

;=====beginning of calc function=====
calc:
;c^2 = a^2 + b^2
;xmm15 = a
;xmm14 = b
;xmm13 = a^2
;xmm12 = b^2
;xmm11 = (a^2 + b^2) aka c^2
;xmm10 = c

;block square float1, store in xmm13
mov rax, 0
movsd xmm13, xmm15
mulsd xmm13, xmm13

;block square float2, store in xmm12
mov rax, 0
movsd xmm12, xmm14
mulsd xmm12, xmm12

;block xmm13 plus xmm12, store in xmm11
mov rax, 0
movsd xmm11, xmm13
addsd xmm11, xmm12

;block sqrt xmm11, store in xmm10
mov rax, 0
sqrtsd xmm10, xmm11

;block printf The hypotenuse is %1.5lf
mov rax, 1
mov rdi, result
movsd xmm0, xmm10
call printf

;block printf Returning value %1.5lf
mov rax, 1
mov rdi, ending
movsd xmm0, xmm10
call printf
jmp end
;=====end of calc function=====

;=====beginning of end program=====
end:
;return hypotenuse to caller
;if returning non-float, return in rax. if returning float, return in xmm0
;mov rax, 0
movsd xmm0, xmm10

;===== Restore original values to integer registers ===================================================================
popf                                                        ;Restore rflags
pop rbx                                                     ;Restore rbx
pop r15                                                     ;Restore r15
pop r14                                                     ;Restore r14
pop r13                                                     ;Restore r13
pop r12                                                     ;Restore r12
pop r11                                                     ;Restore r11
pop r10                                                     ;Restore r10
pop r9                                                      ;Restore r9
pop r8                                                      ;Restore r8
pop rcx                                                     ;Restore rcx
pop rdx                                                     ;Restore rdx
pop rsi                                                     ;Restore rsi
pop rdi                                                     ;Restore rdi
pop rbp                                                     ;Restore rbp

ret
;=====end of end program=====