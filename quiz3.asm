section .text
    global _start

_start:
    MOV eax, [number]
    
    ; Check if the number is 0 or 1
    CMP eax, 1
    JE end_factorial
    
    MOV ecx, eax
    MOV ebx, 1
    
factorial_loop:
    IMUL ebx, ecx
    DEC ecx
    JNZ factorial_loop

    MOV [factorial], ebx

end_factorial:
    MOV ebx, eax
    MOV [factorial], ebx

    MOV eax, 1
    INT 0x80

section .data
    number db 5

section .bss
    factorial RESB 10