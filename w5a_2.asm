section .data
    num1 dd 1
    num2 dd 30
    num3 dd 5
    num4 dd 25
    num5 dd 15

section .text
    global _start

_start:
    MOV eax, [num1]
    
    ; Compare with num2
    CMP eax, [num2]
    JGE check_num3
    MOV eax, [num2]    ; Update eax to num2 if num2 greater than eax
    
check_num3:
    ; Compare with num3
    CMP eax, [num3]
    JGE check_num4
    MOV eax, [num3]    ; Update eax to num3 if num3 greater than eax
    
check_num4:
    ; Compare with num4
    CMP eax, [num4]
    JGE check_num5
    MOV eax, [num4]    ; Update eax to num4 if num4 greater than eax
    
check_num5:
    ; Compare with num5
    CMP eax, [num5]
    JGE done
    MOV eax, [num5]    ; Update eax to num5 if num5 greater than eax

done:
    MOV [result], eax

    MOV EAX, 1
    INT 0x80

segment .bss
    result resb 1