SECTION .text
global _start

_start:
    MOV eax, 5
    MOV ebx, filename
    MOV ecx, 0101h
    INT 0x80

    MOV [fd_out], eax

    MOV eax, 19
    MOV ebx, [fd_out]
    mov ecx, 0
    MOV edx, 2
    INT 0x80

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
    line1 DB 'Better three hours too soon than a minute too late.', 0h
    len1 EQU $ - line1
    line2 DB 'No legacy is so rich as honesty.', 0h
    len2 EQU $ - line2

SECTION .bss
    fd_out RESB 1