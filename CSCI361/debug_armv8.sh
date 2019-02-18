#!/bin/bash
#
# Instructions:
# 1. Make this script executable.
#   `sudo chmod +x ./debug_armv8.sh`
# 2. Move this script to /usr/bin/
#   `sudo cp ./debug_armv8.sh /usr/bin/debugv8`
# 3. Execute
#   `debugv8 [filepath]
aarch64-linux-gnu-as -g -o a.o $1
aarch64-linux-gnu-gcc -static -o a.elf a.o
aarch64-linux-gnu-gdb a.elf 
# remove the temporary files after execution
rm -f a.o a.elf