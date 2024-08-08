SECTION .text
global _start

_start:
    ; Encrypt the message
    MOV esi, msg
    MOV edi, encrypted
    MOV ecx, msg_len ; loop counter
    MOV ebx, key
    MOV edx, key_len
    MOV ebp, 0

enc_loop:
    MOV al, [esi] ; Load message character
    MOV dl, [ebx + ebp] ; Load key character
    XOR al, dl ; Perform XOR operation to encrypt
    MOV [edi], al ; Store encrypted byte into 'encryped' variable buffer
    ; Move to the next byte of the message, encrypted variable bufer, and key
    INC esi
    INC edi
    INC ebp

    ; Reset the key index if it is >= the key length
    CMP ebp, edx
    JAE reset_key_index

    DEC ecx ; reduce loop counter
    JNZ enc_loop
    JMP done_encrypt ; finish encryption if loop is done

reset_key_index:
    XOR ebp, ebp ; sets it to 0
    JMP enc_loop

done_encrypt:
    ; Decrypt the message
    MOV esi, encrypted
    MOV edi, decrypted
    MOV ecx, msg_len ; loop counter
    MOV ebx, key
    MOV edx, key_len
    MOV ebp, 0

dec_loop:
    MOV al, [esi] ; Load current encrypted byte
    MOV dl, [ebx + ebp] ; Load key character
    XOR al, dl
    MOV [edi], al
    INC esi
    INC edi
    INC ebp
    CMP ebp, edx
    JAE reset_key_index_dec
    DEC ecx
    JNZ dec_loop
    JMP done_decrypt

reset_key_index_dec:
    XOR ebp, ebp ; sets it to 0
    JMP dec_loop

done_decrypt:
    ; Create/Open file
    MOV eax, 8
    MOV ebx, filename
    MOV ecx, 0101h
    MOV edx, 0666h
    INT 0x80

    MOV [fd], eax

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
