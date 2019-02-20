segment .text
	global _start

_start:
	mov ecx,msg
	mov edx,len
	mov eax,4
	mov ebx,1
	int 0x80

	mov ebx, 2
	mov eax, 3
	mov ecx, enterchoice
	mov edx, 2
	int 0x80
    
	mov ecx,entermsg
	mov edx,entermsglen
	mov eax,4
	mov ebx,1
	int 0x80

	mov ebx, 2
	mov eax, 3
	mov ecx, num1
	mov edx, 2
	int 0x80

	mov ebx, 2
	mov eax, 3
	mov ecx, num2
	mov edx, 2
	int 0x80

	mov ebx, 1
	mov eax, 4
	mov ecx, resultmsg
	mov edx, resultmsglen
	int 0x80

	mov al,byte [enterchoice]		;casting user input to byte

	;comparing with the user input
	cmp al,'2'
	je _substraction

	cmp al,'3'
	je _multiplication

	cmp al,'4'
	je _division

_addition:	
	xor eax,eax
	xor ebx,ebx
	xor edx,edx

	mov al, byte [num1]
	sub al, '0'
	mov bl, byte [num2]
	sub bl, '0'
	add al, bl
	mov [digit2], al
	mov ah, 0
	cmp al,10
	jl last_digit

	mov bx,10 
	div bx
	add ax,'0'
	mov [digit1], ax
	mov [digit2], dx

	mov ecx, digit1
	mov eax, 4
	mov ebx, 1
	mov edx, 2
	int 0x80

last_digit:
	mov eax,[digit2]
	add eax,'0'
	mov [digit2],eax

	mov ecx, digit2
	mov eax, 4
	mov ebx, 1
	mov edx, 2
	int 0x80

	mov ecx, newline
	mov eax, 4
	mov ebx, 1
	mov edx, newlinelen
	int 0x80

	jmp _exit

_substraction:
	mov al, byte [num1]
	sub al, '0'
	mov bl, byte [num2]
	sub bl, '0'
	cmp al,bl
	jg _subs

	mov eax, 4
	mov ebx, 1
	mov ecx, minus
	mov edx, minuslen
	int 0x80

	mov al, byte [num2]
	sub al, '0'
	mov bl, [num1]
	sub bl, '0'

_subs:
	sub al, bl
	add al, '0'
	mov ah, 0
	mov [digit1], eax

	mov eax, 4
	mov ebx, 1
	mov ecx, digit1
	mov edx, 2
	int 0x80

	mov ecx, newline
	mov eax, 4
	mov ebx, 1
	mov edx, newlinelen
	int 0x80

	jmp _exit

_multiplication:
	xor eax,eax
	xor ebx,ebx
	xor edx,edx

	mov al, byte [num1]
	sub al, '0'
	mov bl, byte [num2]
	sub bl, '0'
	mul bl
	mov [digit2], al
	mov ah, 0
	cmp al,10
	jl last_digit2

	mov bx,10 
	div bx
	add ax,'0'
	mov [digit1], ax
	mov [digit2], dx

	mov ecx, digit1
	mov eax, 4
	mov ebx, 1
	mov edx, 2
	int 0x80

last_digit2:
	mov eax,[digit2]
	add eax,'0'
	mov [digit2],eax

	mov ecx, digit2
	mov eax, 4
	mov ebx, 1
	mov edx, 2
	int 0x80

	mov ecx, newline
	mov eax, 4
	mov ebx, 1
	mov edx, newlinelen
	int 0x80

	jmp _exit

_division:
	xor eax,eax
	xor ebx,ebx
	xor edx,edx

	mov ecx, newline
	mov eax, 4
	mov ebx, 1
	mov edx, newlinelen
	int 0x80

	mov al, byte [num1]
	sub al, '0'
	mov bl, byte [num2]
	sub bl, '0'
	mov ah, 0

	div bl
	add al,'0'
	mov [digit1], al
	add ah,'0'
	mov [digit2], ah

	mov ecx, quotient
	mov eax, 4
	mov ebx, 1
	mov edx, quotientlen
	int 0x80

	mov ecx, newline
	mov eax, 4
	mov ebx, 1
	mov edx, newlinelen
	int 0x80

	mov ecx, digit1
	mov eax, 4
	mov ebx, 1
	mov edx, 2
	int 0x80

	mov ecx, newline
	mov eax, 4
	mov ebx, 1
	mov edx, newlinelen
	int 0x80

	mov ecx, remainder
	mov eax, 4
	mov ebx, 1
	mov edx, remainderlen
	int 0x80

	mov ecx, newline
	mov eax, 4
	mov ebx, 1
	mov edx, newlinelen
	int 0x80

	mov ecx, digit2
	mov eax, 4
	mov ebx, 1
	mov edx, 2
	int 0x80

	mov ecx, newline
	mov eax, 4
	mov ebx, 1
	mov edx, newlinelen
	int 0x80

_exit:
	mov eax, 1
	int 0x80

segment .data
	msg db "Please enter your choice:", 0xA , "	1. Addition", 0xA, "	2. Subtraction", 0xA, "        3. Multiplication", 0xA, "        4. Division", 0xA
	len equ $- msg

	entermsg db "Enter two numbers:", 0xA
	entermsglen equ $-entermsg

	resultmsg db "The result is "
	resultmsglen equ $- resultmsg

	newline db 0xA
	newlinelen equ $- newline

	minus db "-"
	minuslen equ $- minus

	quotient db "Quotient "
	quotientlen equ $- quotient

	remainder db "Remainder "
	remainderlen equ $- remainder

segment .bss
	enterchoice resb 2
	num1 resb 2
	num2 resb 2
	digit2 resb 2
	digit1 resb 2