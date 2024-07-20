section .text
global _start

_start:
    MOV ebx, 0 ; start ebx at 0

label:
    INC ebx ; increase ebx by 1
    CMP ebx, 5 ; compare ebx to 5
    JL label ; restart at line 7 if ebx is less than 5

    MOV eax, 1
    INT 0x80