section .text
global _start

_start:
    mov al, [a]
    mov dl, [b]
    mul dl
    mov ebx, eax
    mov al, [c]
    mov dl, [d]
    mul dl
    ADD ebx, eax

    mov eax, 1
    int 0x80

section .data:
    a dd 2
    b dd 4
    c dd 8
    d dd 10

