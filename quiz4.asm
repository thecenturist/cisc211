SECTION .text
global _start


_start:
    MOV eax, [x]
    MOV ebx, [y]
    MOV ecx, [z]

    CALL addition

    MOV [result], eax

    MOV eax, 1
    INT 0x80

addition:
    ADD eax, ebx
    ADD eax, ecx
    RET

SECTION .data:
    x DD 10
    y DD 10
    z DD 15

SECTION .bss
    result RESD 1