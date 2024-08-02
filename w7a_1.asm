SECTION .text
global _start

_start:
    MOV eax, 8
    MOV ebx, filename
    MOV ecx, 0711o
    INT 0x80

    MOV [fd_out], eax

    MOV eax, 4
    MOV ebx, [fd_out]
    mov ecx, line1
    MOV edx, len1
    INT 0x80

    MOV eax, 4
    MOV ebx, [fd_out]
    MOV ecx, newline
    MOV edx, 1
    INT 0x80

    MOV eax, 4
    MOV ebx, [fd_out]
    mov ecx, line2
    MOV edx, len2
    INT 0x80

    MOV eax, 4
    MOV ebx, [fd_out]
    mov ecx, newline
    MOV edx, 1
    INT 0x80

    MOV eax, 6
    MOV ebx, [fd_out]
    INT 0x80

    MOV eax, 1
    INT 0x80

SECTION .data
    filename DB 'quotes.txt', 0h
    newline DB 0xA
    line1 DB 'To be, or not to be, that is the question.', 0h
    len1 EQU $ - line1
    line2 DB 'A fool thinks himself to be wise, but a wise man knows himself to be a fool.', 0h
    len2 EQU $ - line2

SECTION .bss
    fd_out RESB 1