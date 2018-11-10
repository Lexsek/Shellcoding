#include <stdio.h>
#include <sys/mman.h>
#include <stdint.h>
#include <string.h>

typedef void pf_t(void);

char shellcode[] = "INSERT_YOUR_SHELLCODE";

int main(){

    printf("Shellcode length : %d bytes", strlen(shellcode));
    // Prints shellcode length in bytes
    mprotect((pf_t*)((uint64_t)shellcode & ~4095), 4096, 0x4);
    // PROT_EXEC on page that contains the shellcode
    ((pf_t*) shellcode)();
    // Execute the shellcode
    return 0;

}
