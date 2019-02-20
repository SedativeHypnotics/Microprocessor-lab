segment .text
	global _start

_start:
	mov ax, 20
	mov bx, 10
	div bx
	add ax,'0'
	mov [temp],ax

	mov ecx, temp
	mov eax, 4
	mov ebx, 1
	mov edx, 2
	int 0x80

	mov eax, 1
	int 0x80

segment .bss
	temp resb 1