
; Assembly program to calculate the  Factorial of n
; Author:  Maryam Katebzedeh
; Homework 5
; Shiraz University
; Date:    24 Azar 1397

%include "io.h"           ; header file for input/output

%macro fgets 2   ;; str, max len
	PUSHAD
	PUSHF
	MOV EAX,3 	;; FILE READ SERVICE
	MOV EBX,0  	;; 0 = STD INPUT(KEYBOARD)
	MOV ECX,%1  ;; POINTER TO INPUT BUFFER
	MOV EDX,%2 	;; INPUT BUFFER SIZE
	INT 0X80
	DEC EAX
;	MOV [%3],EAX ; LENGTH OF STRING READ
	MOV BYTE[ECX+EAX], 0 ; NULL POINTER
	POPF
	POPAD
%endmacro


%macro puts 1
  pushad
  mov esi, %1

%%for:
  mov eax, 4	;; FILE PRINT SERVICE
  mov ebx, 1	;; 1 = STD OUTPUT (MONITOR)
  mov ecx, esi
  mov edx, 1	;; OUTPUT BUFFER SIZE --->%2IF NOT EQU PROBLEM????
  cmp byte[ecx],0
  je  %%skip
  int 80h
  inc esi
  jmp %%for

%%skip:
  popad
%endmacro



%macro  fact 2
%%set:
  mov    eax ,1
	mov    ebx ,%1
%%factorial:
	cmp    ebx,1
	je     %%found
	imul   eax ,ebx
	dec    ebx
	jmp    %%factorial
%%found:
  mov    %2,eax
%endmacro


%macro   digits 2
    mov    eax ,%1
		mov    esi ,%1
		mov    ebx ,10
		mov    ecx , 0

%%forr:
    cmp    esi ,0
    je     %%find
		mov    eax , esi
    cdq
		idiv   ebx
		inc    ecx
		mov    esi,eax
		jmp    %%forr
%%find :
    mov    %2,ecx
%endmacro

segment .data
	cr					 equ					13     								     ; carriage return character
	lf					 equ					10     								     ; line feed
	newln     	 db          cr,lf,0
	string 			 db					"   ",0
	welcome_msg  db  				cr,lf,"welcome to n! program......",0
  getn_msg		 db          cr,lf,"Please enter integer number n (2 ≤ n ≤ 12): ",0
	error_msg    db          cr,lf,"Oooops,.........Invalid input ....... please try again : ",cr,lf,0
	n            dd          0
	result       db          "           !=            and has                  digits.",cr,lf,0
	nfact        dd          0
	ndigits      dd          0
	continue_msg db          "Do you want to continue (y/n) ? ",0
	end_msg1     db          cr,lf,"Thanks for using the n! program.",0
	end_msg2     db          cr,lf,"You tried the program            times.",cr,lf,0
	msg_Auther          db          cr,lf,"Author:  Maryam Katebzedeh",cr,lf,0                           ;introduction
	mgs_homework        db          cr,lf,"Homework 5" ,cr,lf,0
	msg_date            db          cr,lf,"Date:    24 Azar 1397",cr,lf,0
	msg_explain         db          cr,lf,"Assembly programs using macros ",cr,lf,0



segment  .bss


segment .code   											; start of main program code
	global _start
_start:

	call main

quit:

    mov	   eax, 1										; SYSTEM CALL NUMBER (SYS_EXIT)
    int    80h								      ; INTERRUPT FOR DOS SERVICES	; end of main


main:
		puts      msg_Auther                                          ; Output auther
		puts      mgs_homework                                        ; output homework num
		puts      msg_date                                            ; Output date
		puts      msg_explain                                         ; Output explanation

    puts		welcome_msg

		mov     bp ,1

get_n:
    puts		getn_msg
		fgets 	string,3
		atod    string
		mov     [n],EAX
    cmp     eax,2
		jl      error
		cmp     eax,12
		jg      error
    mov     ecx ,1
		jmp     computing
error:
    puts   error_msg
		jmp    get_n

computing:
    fact   [n] ,[nfact]
		dtoa   result,[n]
		dtoa   result+13,[nfact]
		digits [nfact],[ndigits]
		dtoa   result+32,[ndigits]
		puts   result
    puts   continue_msg
		fgets  string,2
		cmp    byte[string],'y'
		je     increment
		jmp    end_of_program

increment:
    inc    bp
		jmp    get_n


end_of_program:
   puts   end_msg1
	 itoa   end_msg2+25,bp
	 puts		end_msg2


   ret
