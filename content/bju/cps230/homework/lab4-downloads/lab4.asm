; CpS 230 Lab 4: Alice B. College-Student (acoll555)
;---------------------------------------------------
; Warm-up lab exercise to introduce the basics of
; writing, building, and running IA-64 assembly code
; programs on Windows.
;---------------------------------------------------
bits 64
default rel

; We use these functions (printf and scanf) from an external library
extern printf
extern scanf

; Begin the "code" section of our output OBJ file
section .text

; Mark the label "main" as an exported/global symbol
global main

; "main" marks the spot where our code actually is (i.e., calling "main()" takes you here)
main:
    ; Boilerplate "function prologue"
    push rbp
    mov    rbp, rsp
    
    ; Prompt for input [C: printf("Please enter an integer: ");]
    sub rsp, 32
    mov rcx, str_prompt    ; address of format string "Please enter..."
    call printf
    add rsp, 32
    
    ; Read input without checking for input errors [C: scanf("%d", &int_number);]
    sub rsp, 32
    mov rdx, int_number    ; address of QWORD sized variable int_number
    mov rcx, str_pattern ; address of format string "%d"
    call scanf
    add rsp, 32
    
    ; Add number to itself [C: int_number += int_number;]
    mov    rax, [int_number] ; <rax> = int_number
    add    [int_number], rax ; int_number += <rax>
    
    ; Print modified number [C: printf("Your number added to itself is: %d\n", int_number);]
    sub rsp, 32
    mov rdx, qword [int_number]    ; VALUE, not address, of variable int_number
    mov rcx, str_output        ; address of format string "Your number..."
    call printf
    add rsp, 32
    
    ; Put our return value in the <rax> register [C: return 0;]
    mov    rax, 0
    
    ; Boilerplate "function epilogue"/return
    pop    rbp
    ret

; Begin the "data" section of our output OBJ file
section .data

    ; Reserve memory for various 0-terminated strings and mark their starting points in memory with labels
    str_prompt    db    "Please enter an integer: ", 0
    str_pattern    db    "%d", 0
    str_output    db    "Your number added to itself is: %d", 10, 0

    ; Reserve a QWORD (8 bytes) for an integer variable; mark its starting point in memory with the label "int_number"
    int_number    dq    0
