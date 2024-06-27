section .text
	global _start

_start:
	mov eax, 1
	mov ebx, eax
	mov eax, 1
	int 0x80

segment .bss:
	result resb 1

segment .data:
	var1	DW	10
	var2	DW	15
