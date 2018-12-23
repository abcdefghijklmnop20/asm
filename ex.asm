
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
  file          db          "Yas.txt",0
  ex            db          "ex",cr,lf,0
  error         db          "error",cr,lf,0
  cre           db          "creat",cr,lf,0

  string        db          "                            ",0
  buf_size      dd          0



segment  .bss
fd_in     resd  1
in_buff   resb  40

segment .code   											; start of main program code
	global _start
_start:

	call main

quit:

    mov	   eax, 1										; SYSTEM CALL NUMBER (SYS_EXIT)
    int    80h								      ; INTERRUPT FOR DOS SERVICES	; end of main


main:
   mov    dword[buf_size],256
   output file
   mov    ebx , file
   mov    eax , 5
   mov    ecx , 0
   mov    edx , 0700
   int    0x80
   mov    [fd_in],eax

   cmp    eax , 0
   jge    crea

   output error


   jmp    quit

crea:
    
    mov     eax , 3
    mov     ebx ,[fd_in]
    mov     ecx , in_buff
    mov     edx, buf_size
    int     0x80
    mov     eax,6
    output  cre
    output  in_buff

    jmp     quit









   ret
