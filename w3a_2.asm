section .data
    var1 dd 00001010b
    var2 dd 00001010b
    var3 dd 00001010b
    var4 dd 00001010b

segment .bss
    result resb 1

section .text
global _start

_start:
    MOV al, [var1]
    ADD al, [var2]
    ADD al, [var3]
    ADD al, [var4]
    MOV [result], al

    MOV eax, 1
    INT 0x80
