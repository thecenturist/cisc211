section .text
global _start

section .data
    oddtxt db 'odd', 0xA
    eventxt db 'even', 0xA


_start:
    push 9
    call _checknumber

    MOV eax, 1
    INT 0x80

_checknumber:
    PUSH ebp
    MOV ebp, esp
    sub esp, 4

    MOV ebx, [ebp+8]
    AND ebx, 1
    CMP ebx, 0
    JE printeven

    MOV eax, 4 
    MOV edx, 4
    MOV ebx, 1
    MOV ecx, oddtxt
    INT 0x80

    JMP exit

printeven:
    MOV eax, 4 
    MOV edx, 5
    MOV ebx, 1
    MOV ecx, eventxt
    INT 0x80

exit:
    MOV esp, ebp
    POP ebp
    RET