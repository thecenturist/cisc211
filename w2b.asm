global _start

section .data:
	msg db 'I came,', 0xa
	len equ $ - msg
	msg2 db 'I saw,', 0xa
	len2 equ $ - msg2
	msg3 db 'I conquered.', 0xa
	len3 equ $ - msg3

_start:
	mov eax, 4 ; sys_write
	mov ebx, 1 ; stdout
	mov ecx, msg ; move string into ecx
	mov edx, len ; move length into edx
	int 0x80

	mov eax, 4 ; sys_write
	mov ebx, 1 ; stdout
	mov ecx, msg2 ; move string into ecx
	mov edx, len2 ; move length into edx
	int 0x80

	mov eax, 4 ; sys_write
	mov ebx, 1 ; stdout
	mov ecx, msg3 ; move string into ecx
	mov edx, len3 ; move length into edx
	int 0x80

	mov eax, 1
	int 0x80
