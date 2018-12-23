;  This file should be attached to NASM assembly programs
; Author:  Gh. Dastghaibyfard dstghaib@shirazu.ac.ir
;(Shiraz University)
; Date:    25 Shahrivar 1397,  
; To Compile, Link and Execute see readme.txt file
		extern  itoaproc, atoiproc, dtoaproc, atodproc

%macro		itoa   2	;; dest,source   convert integer to ASCII string
            push   ebx          ;; save EBX
            mov    bx,%2		;;
            push   bx           ;; source parameter
            mov    ebx,%1       ;; destination address
            push   ebx          ;; destination parameter
            call   itoaproc     ;; call itoaproc(source,dest)
            pop    ebx          ;; restore EBX
%endmacro

%macro		atoi  1 	;;  source;; convert ASCII string to integer in AX
                                ;; offset of terminating character in ESI
            push   ebx          ;; save EBX
            mov    ebx,%1  		;; source address to EBX
            push   ebx          ;; source parameter on stack
            call   atoiproc     ;; call atoiproc(source)
            pop    ebx          ;; parameter removed by ret
%endmacro

%macro		dtoa   2    ;; dest,source   ;; convert double to ASCII string
            push   ebx      ;; save EBX
            mov    ebx,%2
            push   ebx      ;; source parameter
            mov    ebx,%1   ;; destination address
            push   ebx      ;; destination parameter
            call   dtoaproc ;; call dtoaproc(source,dest)
            pop    ebx      ;; restore EBX
%endmacro

%macro	atod        1 	;;source;; convert ASCII string to integer in EAX
                              ;; offset of terminating character in ESI
            mov   eax,%1	  ;; source address to EAX
            push   eax        ;; source parameter on stack
            call   atodproc   ;; call atodproc(source)
                              ;; parameter removed by ret
%endmacro

	; print a string
%macro output 2
  pushad
  mov eax, 4	;; FILE PRINT SERVICE
  mov ebx, 1	;; 1 = STD OUTPUT (MONITOR)
  mov ecx, %1	;; POINTER TO OUTPUT BUFFER
  mov edx, [%2]	;; OUTPUT BUFFER SIZE --->%2IF NOT EQU PROBLEM????
  int 80h
  popad
%endmacro

%macro output 1
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

	; READ A STRING
%macro input 2   ;; str, max len
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
