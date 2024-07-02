section .text
global _start

_start:
    MOV eax, 0
    TEST eax, eax
    JE ifzero

    MOV eax, 'n'
    MOV [result], eax

    MOV eax, 1
    int 0x80

ifzero:
    MOV eax, 'y'
    mov [result], eax
    MOV eax, 1
    INT 0x80

segment .bss
    result resb 1