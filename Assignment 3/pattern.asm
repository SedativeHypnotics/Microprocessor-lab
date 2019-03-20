section .text
	GLOBAL _start

_start:
	;clearing registers
	xor eax, eax
	xor ebx, ebx
	xor ecx, ecx
	xor edx, edx

	;printing prompt message
	mov eax, 4
	mov ebx, 1
	mov ecx, msg
	mov edx, msglen
	int 0x80

	;reading user input
	mov eax, 3
	mov ebx, 2
	mov ecx, num
	mov edx, 2
	int 0x80

	;initiating ecx
	xor eax, eax
	mov al, byte [num]
	sub al, '0'
	mov ecx, eax

_loop1:
	;pushing ecx value in the stack
	push ecx

_loop2:
	;pushing ecx value in the stack
	push ecx

	;printing star
	;add ecx, '0'
	;mov [temp], ecx

	mov eax, 4
	mov ebx, 1
	mov ecx, star
	mov edx, 1
	int 0x80

	;popping from stack
	pop ecx
	loop _loop2

	;printing newline
	mov eax, 4
	mov ebx, 1
	mov ecx, newline
	mov edx, 1
	int 0x80

	pop ecx
	loop _loop1

_exit:
	mov eax, 1
	mov ebx, 0
	int 0x80

section .data
	msg db "Please enter your digit:", 0xA
	msglen equ $- msg
	star db "*"
	newline db 0xA

section .bss
	num resb 2
	temp resb 2