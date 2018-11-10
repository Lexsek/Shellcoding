# Shellcoding
Stuff related to shellcoding (shellcodes, tools, examples, tutorials)

## Cheatsheet

### 32 bits ELF

#### Calling convention

Syscall in EAX
Arguments : EBX, ECX, EDX, ESI, EDI, EBP
Return value in EAX

### 64 bits ELF

#### Calling convention

Syscall in RAX
RDI, RSI, RDX, RCX, R8, R9
Return value in RAX

#### Calling convention

## Tools

### dump_shellcode.sh

Dumps a shellcode string from a valid ELF file using objdump

I recommend you creating an alias pointing to the dump_shellcode.sh
