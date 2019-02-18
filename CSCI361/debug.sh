#!/bin/bash
#
# Instructions:
# 1. Make this script executable.
#   `sudo chmod +x ./debug.sh`
# 2. Move this script to /usr/bin/
#   `sudo cp ./debug.sh /usr/bin/debug`
# 3. Execute
#   `debug [filepath]`
arm-none-eabi-as -g $1 -o a.o
arm-none-eabi-gcc -nostdlib a.o -o a.elf
arm-none-eabi-gdb a.elf
# remove the temporary files after execution
rm -f a.o a.elf