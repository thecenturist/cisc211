section .text
global _start

section .data
    nl db 0xA

_start:
    MOV BYTE [res], 'A'

output:
    MOV edx,1       ;output length
    MOV ebx,1       ;stdout
    MOV eax,4       ;system call (sys_write)
    MOV ecx, res
    INT 0x80        ;interrupt kernel

    MOV eax, 4
    MOV ebx, 1
    MOV ecx, nl
    MOV edx, 1
    INT 0x80

    cmp BYTE [res], 'Z'
    JE exit

    INC BYTE [res]
    jmp output

exit:
    MOV eax,1
    INT 0x80

segment .bss
    res RESB 1