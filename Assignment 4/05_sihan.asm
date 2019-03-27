section .text
	GLOBAL _start

_start:
	;clearing registers
	xor eax, eax
	xor ebx, ebx
	xor ecx, ecx
	xor edx, edx

	;printing opening message
	mov eax, 4
	mov ebx, 1
	mov ecx, msg
	mov edx, msglen
	int 0x80

	;getting input from user
	mov eax, 3
	mov ebx, 2
	mov ecx, num
	mov edx, 2
	int 0x80

	mov al, byte [num]
	mov ah, 0
	sub eax, '0'

	;comparing the number
	cmp eax, 1
	je _star

	cmp eax, 2
	je _number

	cmp eax, 3
	je _star_star_combination

	;printing invalid message
	mov eax, 4
	mov ebx, 1
	mov ecx, invalid
	mov edx, invalidlen
	int 0x80

	jmp _exit

_star:
	;clearing registers
	xor eax, eax
	xor ebx, ebx
	xor ecx, ecx
	xor edx, edx

	;showing prompt message
	mov eax, 4
	mov ebx, 1
	mov ecx, prompt
	mov edx, promptlen
	int 0x80

	;getting user input
	mov eax, 3
	mov ebx, 2
	mov ecx, num
	mov edx, 2
	int 0x80

	mov ah, 0
	mov al, byte[num]
	sub ax, '0'
	mov ecx, eax
	mov [temp], ecx
	call procedure1
	jmp _exit

_number:
	;clearing registers
	xor eax, eax
	xor ebx, ebx
	xor ecx, ecx
	xor edx, edx

	;showing prompt message
	mov eax, 4
	mov ebx, 1
	mov ecx, prompt
	mov edx, promptlen
	int 0x80

	;getting user input
	mov eax, 3
	mov ebx, 2
	mov ecx, num
	mov edx, 2
	int 0x80

	mov ah, 0
	mov al, byte[num]
	sub ax, '0'
	mov ecx, eax
	mov [temp], ecx
	call procedure2
	jmp _exit

_star_star_combination:
	;clearing registers
	xor eax, eax
	xor ebx, ebx
	xor ecx, ecx
	xor edx, edx

	;showing prompt message
	mov eax, 4
	mov ebx, 1
	mov ecx, prompt
	mov edx, promptlen
	int 0x80

	;getting user input
	mov eax, 3
	mov ebx, 2
	mov ecx, num
	mov edx, 2
	int 0x80

	mov ah, 0
	mov al, byte[num]
	sub ax, '0'
	mov ecx, eax
	call procedure3
	jmp _exit 
	
procedure1:
	_loop1:
		push ecx
		mov ah, 0
		mov al, [temp]
		sub eax, ecx
		add eax, 1
		mov ecx, eax

		_loop2:
			push ecx

			;printing number
			mov eax, 4
			mov ebx, 1
			mov ecx, starr
			mov edx, 1
			int 0x80

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
		ret

procedure2:

	_loop3:
		push ecx
		mov ah, 0
		mov al, [temp]
		sub eax, ecx
		add eax, 1
		mov ecx, eax
		mov [temp2], ecx

		_loop4:
			push ecx
			mov ah, 0
			mov al, [temp2]
			sub eax, ecx
			add eax, 1
			add eax, '0'
			mov [temp3], al

			;printing number
			mov eax, 4
			mov ebx, 1
			mov ecx, temp3
			mov edx, 1
			int 0x80

			pop ecx
			loop _loop4

		;printing newline
		mov eax, 4
		mov ebx, 1
		mov ecx, newline
		mov edx, 1
		int 0x80

		pop ecx
		loop _loop3
		ret

procedure3:
	_loop5:
		push ecx
		_loop6:
		push ecx

		;printing star
		mov eax, 4
		mov ebx, 1
		mov ecx, starr
		mov edx, 1
		int 0x80

		pop ecx
		loop _loop6

	;printing newline
	mov eax, 4
	mov ebx, 1
	mov ecx, newline
	mov edx, 1
	int 0x80

	pop ecx
	loop _loop5
	ret


_exit:
	;clearing registers
	xor eax, eax
	xor ebx, ebx
	xor ecx, ecx
	xor edx, edx

	mov eax, 1
	int 0x80

section .data
	msg db "Please enter your choice:", 0xA, "	1. Star", 0xA, "	2. Digit", 0xA, "	3. Star Star Combination", 0xA
	msglen equ $- msg
	prompt db "Enter number", 0xA
	promptlen equ $- prompt
	invalid db "Invalid input!", 0xA
	invalidlen equ $- invalid
	starr db "*"
	newline db 0xA

section .bss
	num resb 2
	temp resb 1
	temp2 resb 1
	temp3 resb 1