section .data
    a times 10000 dd 0             ; Array of 10k elements initialized to 0
    format db "%d", 10, 0          ; Format string for printf
    invalid_msg db "Invalid input. Please provide a positive integer.", 10, 0 ; Error message

section .bss
    result resd 1                  ; Space for the result

section .text
    global _start
    extern atoi, rand, printf      ; External functions

_start:
    ; Prologue
    mov rdi, [rsp + 8]             ; argc
    cmp rdi, 2                     ; Check if argc < 2
    jl invalid_input               ; If not enough args, jump to invalid_input

    ; Get input number from command line
    mov rsi, [rsp + 16]            ; argv[1]
    mov rdi, rsi                   ; Set up argument for atoi
    call atoi                      ; atoi(argv[1])
    mov esi, eax                   ; esi = atoi(argv[1])
    test esi, esi                  ; Check if u == 0
    jz invalid_input               ; If u == 0, jump to invalid_input

    ; Generate random number
    call rand                      ; rand()
    mov edi, 10000
    xor edx, edx                   ; Clear high bits of rdx
    div edi                        ; rdx = rand() % 10000
    mov r8d, edx                   ; r8d = r

    ; Initialize array and perform calculations
    xor r9d, r9d                   ; r9d = i (outer loop)
outer_loop:
    cmp r9d, 10000                 ; Check if i < 10000
    jge end_outer_loop             ; If i >= 10000, exit loop

    xor r10d, r10d                 ; r10d = j (inner loop)
    mov r11d, [a + r9d * 4]        ; Load a[i] into r11d

inner_loop:
    cmp r10d, 100000               ; Check if j < 100000
    jge end_inner_loop             ; If j >= 100000, exit loop

    xor edx, edx                   ; Zero out edx for div operation
    mov eax, r10d                  ; eax = j
    div esi                        ; edx = j % u
    add r11d, edx                  ; a[i] += j % u
    inc r10d                       ; j++

    jmp inner_loop                 ; Continue inner loop

end_inner_loop:
    add r11d, r8d                  ; a[i] += r
    mov [a + r9d * 4], r11d        ; Store result back into a[i]
    inc r9d                        ; i++

    jmp outer_loop                 ; Continue outer loop

end_outer_loop:
    ; Print a[r]
    mov eax, [a + r8d * 4]         ; eax = a[r]
    mov [result], eax              ; Store in result

    lea rdi, [format]              ; Format string
    mov rsi, [result]              ; Value to print
    xor rax, rax                   ; Clear rax for printf
    call printf                    ; Call printf

    ; Exit program
    mov rax, 60                    ; syscall: exit
    xor rdi, rdi                   ; status: 0
    syscall

invalid_input:
    ; Handle invalid input
    lea rdi, [invalid_msg]         ; Load the address of the error message
    xor rax, rax                   ; Clear rax for printf
    call printf                    ; Call printf to print the message

    mov rax, 60                    ; syscall: exit
    xor rdi, rdi                   ; status: 0
    syscall                        ; Exit program

