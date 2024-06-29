global _start

segment .bss
	result RESB 0 

segment .data
	var1 DW 10 ; initialize var1
	var2 DW 15 ; initialize var2

_start:
	mov eax, [var1] ; move the bytes in memory at var1 into eax
	add eax, [var2] ; add the bytes in memory at var2 to eax
	mov [result], eax
	mov ebx, [result]

	mov eax, 1 ; sys_exit
	int 0x80 ; program exit
