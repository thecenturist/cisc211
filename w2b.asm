global _start

section .data:
	msg db 'I came,', 0xa
	msg2 db 'I saw,', 0xa
	msg3 db 'I conquered.', 0xa
	len equ $ - msg

_start:
	mov eax, 4 ; sys_write
	mov ebx, 1 ; stdout
	mov ecx, msg ; move string into ecx
	mov edx, len ; move length into edx
	int 0x80

	mov eax, 1
	int 0x80
