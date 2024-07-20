section .text
global _start

_start:
    MOV eax, [array]    ; initially set to the first element in the array
    MOV ecx, 1          ; loop counter

compare_largest:
    CMP dword [array + ecx * 4], eax ; compare array[ecx] with current maximum in EAX
    JLE move_on
    MOV eax, [array + ecx * 4]

move_on:
    INC ecx ; increase loop counter
    CMP ecx, array_len  ; have we reached the end?
    JL compare_largest

    MOV ebx, eax ; largest value stored in ebx

    MOV EAX, 1
    INT 0x80

section .data
    array dd 15, 10, 4 
    array_len equ ($ - array) / 4 ; 3 integers of 4 bytes each