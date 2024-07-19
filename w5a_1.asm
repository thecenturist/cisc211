section .data
    end DD 20
    here DD 0

segment .bss
    result resb 1

section .text
global _start

_start:
    MOV dl, [here]
    CMP dl, [end]
    JL checkeven
    JMP exit

checkeven:
    MOV al, dl
    AND al, 1
    CMP al, 0
    JNZ odd
    MOV [result], dl

    INC dl
    CMP dl, [end]
    JL checkeven

odd:
    INC dl
    CMP dl, [end]
    JL checkeven

exit:
    MOV eax,1
    INT 0x80