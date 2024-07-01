section .data
    var1 dd 00001010b

segment .bss
    result resb 1

section .text
global _start

_start:
    MOV al, [var1]
    NEG al
    MOV ah, 00001010b
    MUL ah
    MOV [result], al
    MOV bl, [result]

    MOV eax, 1
    INT 0x80