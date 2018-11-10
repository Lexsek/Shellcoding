# Shellcoding
Stuff related to shellcoding (shellcodes, tools, examples, tutorials)

## Cheatsheet

### 32 bits ELF

#### Calling convention

Syscall in EAX

Arguments : EBX, ECX, EDX, ESI, EDI, EBP

Return value in EAX

syscall with int 0x80

### 64 bits ELF

#### Calling convention

Syscall in RAX

Arguments : RDI, RSI, RDX, R10, R9, R8

Return value in RAX

syscall with syscall

#### Calling convention

## Tools

### dump_shellcode.sh

Dumps a shellcode string from a valid ELF file using objdump

I recommend you creating an alias pointing to the dump_shellcode.sh

### shellcode_executor.c

Executes a shellcode in C

Be careful about the fact that the shellcode is 32 or 64 bits.

##### 32 bits shellcode

gcc -m32 shellcode_executor.c -o shellcode_32.elf 

##### 64 bits shellcode

gcc shellcode_executor.c -o shellcode_64.elf

### shellcode_executor.py

Executes a shellcode in python

#### Usage :

./shellcode_executor.py <file>
  
The file must contains the shellcode like this :
 
\xef\xbe\xad\xde
