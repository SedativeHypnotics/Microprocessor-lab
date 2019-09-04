section .text
	GLOBAL _start

_start:
	mov eax, 4
	mov ebx, 1
	mov ecx, msg
	mov edx, len
	int 0x80

	mov eax, 3
	mov ebx, 2
	mov ecx, num
	mov edx, 3
	int 0x80

	mov eax, 4
	mov ebx, 1
	mov ecx, en
	mov edx, enlen
	int 0x80

	mov al, byte [num]
	sub al, '0'
	mov [value], eax
	add eax, '0'
	mov [temp], eax

	mov eax, 4
	mov ebx, 1
	mov ecx, temp
	mov edx, 1
	int 0x80

	mov cx, [num+1]
	cmp cx, 0xA
	je _frequency

	mov eax, 4
	mov ebx, 1
	mov ecx, zero
	mov edx, 1
	int 0x80

	mov eax, 10
	mov [fin], eax
	mov [value], eax

_frequency:
	mov eax, 4
	mov ebx, 1
	mov ecx, numbers
	mov edx, nlen
	int 0x80

	mov ecx, [value]
	mov [fin], ecx
	mov edi, 0

_loop:
	push ecx

	mov eax, 3
	mov ebx, 2
	mov ecx, temp
	mov edx, 2
	int 0x80

	mov al, byte[temp]
	mov [array+edi], al

	inc edi

	pop ecx
	loop _loop

	mov eax, 4
	mov ebx, 1
	mov ecx, mynum
	mov edx, mlen
	int 0x80

	mov eax, 3
	mov ebx, 2
	mov ecx, exnum
	mov edx, 2
	int 0x80

	mov bl, byte[exnum]
	mov ecx, [fin]
	mov edi, 0
	mov eax, 0
	mov [answer], eax

_loop2:
	push ecx

	mov al, byte [array+edi]
	cmp eax, ebx
	jne _control
	mov eax, [answer]
	inc eax
	mov [answer], eax

_control:
	pop ecx
	inc edi
	loop _loop2

	mov eax, 4
	mov ebx, 1
	mov ecx, freq
	mov edx, flen
	int 0x80

	mov eax, [answer]
	mov ebx, 10
	cmp eax, ebx
	je _print
	add eax, '0'
	mov [answer], eax

	mov eax, 4
	mov ebx, 1
	mov ecx, answer
	mov edx, 1
	int 0x80

	mov eax, 4
	mov ebx, 1
	mov ecx, nl
	mov edx, 1
	int 0x80

	jmp _exit

_print:
	mov eax, 4
	mov ebx, 1
	mov ecx, ten
	mov edx, tlen
	int 0x80
	
_exit:
	mov eax, 1
	mov ebx, 0
	int 0x80

section .data
	msg db "Enter number", 0xA
	len equ $- msg
	msg2 db "not ten"
	len2 equ $- msg2
	en db "Enter "
	enlen equ $- en
	numbers db " numbers", 0xA
	nlen equ $- numbers
	mynum db "Enter n", 0xA
	mlen equ $- mynum
	ten db "10", 0xA
	tlen equ $- ten
	nl db 0xA
	freq db "Frequency", 0xA
	flen equ $- freq
	zero db "0"

section .bss
	num resb 3
	value resb 2
	array resb 10
	temp resb 2
	exnum resb 2
	answer resb 2
	fin resb 2