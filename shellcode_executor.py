#!/usr/bin/python

import ctypes
import sys

with open(sys.argv[1], 'r') as shellcode_file:
    shellcode = shellcode_file.read().replace("\\x","")
    # Reads the shellcode from the file given in argument
    shellcode_data = bytes.fromhex(shellcode)
    # Transforms the shellcode in binary format

shellcode = ctypes.create_string_buffer(shellcode_data)
# Creates a buffer containing the shellcode
function = ctypes.cast(shellcode, ctypes.CFUNCTYPE(None))
# Creates a function with the shellcode
addr = ctypes.cast(function, ctypes.c_void_p).value
# Get the address of the function
libc = ctypes.CDLL('libc.so.6')
# Import libc
pagesize = libc.getpagesize()
# Get the system page size
addr_page = (addr // pagesize) * pagesize
# Get the first page start address

for page_start in range(addr_page, addr + len(shellcode_data), pagesize):
    libc.mprotect(ctypes.cast(page_start, ctypes.c_void_p), pagesize, 0x4) == 0
    # Crawls pages where the shellcode is and give PROT_EXECUTE rights to the pages

function()
# Call the shellcode
