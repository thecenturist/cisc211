section .data
    var1 dd 5
    var2 dd 5

segment .bss
    result resb 1

section .text
global _start

_start:
    MOV al, [var1]
    MOV ah, 2
    MUL ah
    MOV [result], al
    
    MOV al, [var2]
    SUB al, 3
    MOV bl, al
    MOV ax, [result]
    AND ax, 0ffh ; clear ah from ax and leave al
    DIV bl
    
    MOV [result], al

    MOV eax, 1
    INT 0x80
