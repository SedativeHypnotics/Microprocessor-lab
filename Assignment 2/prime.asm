section	.text
   global _start        ;must be declared for using gcc
	
_start:
	;print input message
	mov eax, 4
	mov ebx, 1
	mov ecx, inputmsg
	mov edx, inputlen
	int 0x80
	
	;getting input
	mov eax, 3
	mov ebx, 2
	mov ecx, num
	mov edx, 2
	int 0x80

	;initializing number of divisors
	mov eax, 0
	mov [divisors], eax

	;moving value of the loop
	mov ecx, 9

_loop:
	;cleaning registers
	xor eax, eax
	xor ebx, ebx
	xor edx, edx

	;storing loop limit value
	mov ebx, ecx
	push ecx

	;cleaning regiaters
	xor ecx, ecx
	

	;getting the number
	mov al, byte[num]
	sub al, '0'
	mov ah, 0
	mov bh, 0

	;divisor check
	div bl
	cmp ah, 0
	jg _increment
	mov eax, [divisors]
	add eax, 1
	mov [divisors], eax

_increment:
	pop ecx
	cmp ecx, 1
	je _print
	loop _loop

_print:
	mov eax, [divisors]
	cmp eax, 2
	je _prime

	;printing not prime
	mov eax, 4
	mov ebx, 1
	mov ecx, num
	mov edx, 2
	int 0x80

	mov eax, 4
	mov ebx, 1
	mov ecx, nomsg
	mov edx, nolen
	int 0x80
	jmp _exit

_prime:
	;printing prime
	mov eax, 4
	mov ebx, 1
	mov ecx, num
	mov edx, 2
	int 0x80

	mov eax, 4
	mov ebx, 1
	mov ecx, msg
	mov edx, len
	int 0x80
	jmp _exit

_exit:
	mov eax, 1
	mov ebx, 0
	int 0x80

section .data
	msg db " is prime", 0xA
	len equ $- msg
	nomsg db " is not prime", 0xA
	nolen equ $- nomsg
	inputmsg db "Please enter your digit:", 0xA
	inputlen equ $-inputmsg
section	.bss
	num resb 1
	divisors resb 1