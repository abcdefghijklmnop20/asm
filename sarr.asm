
; Assembly program to calculate the  Factorial of n
; Author:  Maryam Katebzedeh
; Homework 5
; Shiraz University
; Date:    24 Azar 1397

%include "io.h"           ; header file for input/output


segment .data
	cr					 equ					13     								     ; carriage return character
	lf					 equ					10     								     ; line feed
	newln     	 db          cr,lf,0
  string       times 			155 db ' '
  


segment  .bss
arr 	resd	40

segment .code   											; start of main program code
	global _start
_start:

	call main

quit:

    mov	   eax, 1										; SYSTEM CALL NUMBER (SYS_EXIT)
    int    80h								      ; INTERRUPT FOR DOS SERVICES	; end of main


main:
	 input string ,153
	 mov   ebx , 0
	 mov   dword[arr+ebx],string
	 output dword[arr]
	 output newln
	 input string ,10
	 add   ebx , 4

	 mov   dword[arr+ebx],string
	 output dword[arr+ebx]

   ret
