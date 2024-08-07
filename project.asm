SECTION .text
global _start

_start:
    MOV esi, msg
    MOV edi, encrypted
    MOV ecx, msg_len 

enc_loop:
    MOV al, [esi]
    MOV bl, [key]
    XOR al, bl
    MOV [edi], al
    INC esi
    INC edi
    LOOP enc_loop 

    MOV esi, encrypted
    MOV edi, decrypted
    MOV ecx, msg_len

dec_loop:
    MOV al, [esi]
    MOV bl, [key]
    XOR al, bl
    MOV [edi], al ; Store decrypted byte
    INC esi ; Move to next byte in encrypted message
    INC edi ; Move to next byte in decrypted
    LOOP dec_loop

    ; Create/Open file
    MOV eax, 8
    MOV ebx, filename
    MOV ecx, 0101h
    MOV edx, 0666o
    INT 0x80

    MOV [fd], eax ; Save file descriptor

    ; Write "Plain text: "
    MOV eax, 4
    MOV ebx, [fd]
    MOV ecx, ptxt
    MOV edx, ptxt_len
    INT 0x80

    ; Write msg
    MOV eax, 4
    MOV ebx, [fd]
    MOV ecx, msg
    MOV edx, msg_len 
    INT 0x80

    ; Write newline
    MOV eax, 4
    MOV ebx, [fd]
    MOV ecx, newline
    MOV edx, 1
    INT 0x80

    ; Write "Key: "
    MOV eax, 4
    MOV ebx, [fd]
    MOV ecx, ktxt
    MOV edx, ktxt_len
    INT 0x80

    ; Write key
    MOV eax, 4
    MOV ebx, [fd]
    MOV ecx, key
    MOV edx, key_len
    INT 0x80

    ; Write newline
    MOV eax, 4
    MOV ebx, [fd]
    MOV ecx, newline
    MOV edx, 1
    INT 0x80

    ; Write "Encrypted text: "
    MOV eax, 4
    MOV ebx, [fd]
    MOV ecx, etxt
    MOV edx, etxt_len
    INT 0x80

    ; Write encrypted message
    MOV eax, 4
    MOV ebx, [fd]
    MOV ecx, encrypted
    MOV edx, msg_len
    INT 0x80

    ; Write newline
    MOV eax, 4
    MOV ebx, [fd]
    MOV ecx, newline
    MOV edx, 1
    INT 0x80

    ; Write "Decrypted text: "
    MOV eax, 4
    MOV ebx, [fd]
    MOV ecx, dtxt
    MOV edx, dtxt_len
    INT 0x80

    ; Write decrypted message
    MOV eax, 4
    MOV ebx, [fd]
    MOV ecx, decrypted
    MOV edx, msg_len
    INT 0x80

    ; Write newline
    MOV eax, 4
    MOV ebx, [fd]
    MOV ecx, newline
    MOV edx, 1
    INT 0x80

    ; Close file
    MOV eax, 6
    MOV ebx, [fd] 
    INT 0x80

    ; Exit program
    MOV eax, 1
    INT 0x80

SECTION .data:
    msg DB "HELLO"
    msg_len EQU $ - msg
    key DB "world"
    key_len EQU $ - key
    filename DB 'output.txt', 0
    newline DB 0xA
    ptxt DB 'Plain text: ', 0
    ptxt_len EQU $ - ptxt
    ktxt DB 'Key: ', 0
    ktxt_len EQU $ - ktxt
    etxt DB 'Encrypted text: ', 0
    etxt_len EQU $ - etxt
    dtxt DB 'Decrypted text: ', 0
    dtxt_len EQU $ - dtxt

SECTION .bss
    encrypted RESB 256
    decrypted RESB 256
    fd RESD 1
