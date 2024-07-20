section .data

section .bss
    fibonacci   resd 10      ; Reserve space for 10 Fibonacci numbers (4 bytes each)

section .text
    global _start

_start:
    mov ecx, 10               ; Number of Fibonacci numbers to generate
    mov ebx, fibonacci         ; Address of the array to store Fibonacci numbers

    ; Initialize the first two Fibonacci numbers manually
    mov dword [ebx], 0         ; Fibonacci[0] = 0
    mov dword [ebx + 4], 1     ; Fibonacci[1] = 1

    ; Generate Fibonacci sequence
    mov esi, 2                 ; Start from Fibonacci[2]
    mov edx, 0                 ; EDX will hold the sum

generate_fibonacci:
    mov eax, [ebx + esi*4 - 8] ; Fibonacci[i-1]
    add eax, [ebx + esi*4 - 4] ; Fibonacci[i-2]
    mov [ebx + esi*4], eax     ; Fibonacci[i] = Fibonacci[i-1] + Fibonacci[i-2]

    add edx, eax               ; Add Fibonacci[i] to EDX (sum)

    inc esi                    ; Increment i
    loop generate_fibonacci    ; Loop until ECX becomes 0

    ; EDX now contains the sum of the first 10 Fibonacci numbers

    ; Print the result (optional)
    ; Example:
    ; mov eax, edx              ; Move the sum to EAX for printing or further use
    ; call print_int            ; Example function to print integer in assembly

    ; Exit program (optional)
    ; mov eax, 1                ; syscall number for exit
    ; xor ebx, ebx              ; exit status, 0
    ; int 0x80                  ; make syscall

    ; Or use the appropriate method for exiting the program in your environment

