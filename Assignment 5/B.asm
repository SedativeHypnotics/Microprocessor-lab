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
	mov [fin], eax
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

	mov al, byte[fin]
	mov bl, 1
	cmp al, bl
	je _one

	mov eax, '0'
	mov [max], eax
	mov [smax], eax
	mov edi, 0
	mov cl, byte [fin]
	mov [temp], ecx

_loop2:
	push ecx

	mov al, byte [max]
	mov bl, byte [array+edi]
	cmp eax, ebx
	je _control
	mov al, byte [max]
	mov bl, byte [array+edi]
	cmp eax, ebx
	jg _check
	mov [max], ebx
	mov [smax], eax

	jmp _control

_check:
	mov al, byte [smax]
	mov bl, byte [array+edi]
	cmp eax, ebx
	jg _control
	mov [smax], ebx

_control:
	pop ecx
	inc edi
	loop _loop2

	mov eax, 4
	mov ebx, 1
	mov ecx, smaximum
	mov edx, slen
	int 0x80

	mov eax, 4
	mov ebx, 1
	mov ecx, smax
	mov edx, 1
	int 0x80

	mov eax, 4
	mov ebx, 1
	mov ecx, nl
	mov edx, 1
	int 0x80

	mov eax, 4
	mov ebx, 1
	mov ecx, ind
	mov edx, 6
	int 0x80

	mov edi, 0
	mov bl, byte[smax]
	mov ecx, [temp]

_loop3:
	push ecx
	mov al, byte[array+edi]
	mov bl, byte[smax]
	cmp eax, ebx
	jne _continue

	mov eax, edi
	add eax, 1
	add eax, '0'
	mov [index], eax

	mov eax, 4
	mov ebx, 1
	mov ecx, space
	mov edx, 1
	int 0x80

	mov eax, 4
	mov ebx, 1
	mov ecx, index
	mov edx, 1
	int 0x80
	jmp _continue

_continue:
	pop ecx
	inc edi
	loop _loop3

	mov eax, 4
	mov ebx, 1
	mov ecx, nl
	mov edx, 1
	int 0x80
	jmp _exit

_one:
	mov eax, 4
	mov ebx, 1
	mov ecx, smaximum
	mov edx, slen
	int 0x80

	mov eax, 4
	mov ebx, 1
	mov ecx, array
	mov edx, 1
	int 0x80

	mov eax, 4
	mov ebx, 1
	mov ecx, nl
	mov edx, 1
	int 0x80

	mov eax, 4
	mov ebx, 1
	mov ecx, ind
	mov edx, 6
	int 0x80

	mov eax, 4
	mov ebx, 1
	mov ecx, space
	mov edx, 1
	int 0x80

	mov eax, 1
	add eax, '0'
	mov [temp], eax

	mov eax, 4
	mov ebx, 1
	mov ecx, temp
	mov edx, 1
	int 0x80

	mov eax, 4
	mov ebx, 1
	mov ecx, nl
	mov edx, 1
	int 0x80	

_exit:
	mov eax, 1
	mov ebx, 0
	int 0x80

section .data
	msg db "Enter number", 0xA
	len equ $- msg
	en db "Enter "
	enlen equ $- en
	numbers db " numbers", 0xA
	nlen equ $- numbers
	ten db "10", 0xA
	tlen equ $- ten
	smaximum db "Second Maximum: "
	slen equ $- smaximum
	nl db 0xA
	space db " "
	zero db "0"
	ind db "Index:"

section .bss
	num resb 3
	value resb 2
	array resb 10
	temp resb 2
	fin resb 2
	max resb 2
	smax resb 2
	index resb 2