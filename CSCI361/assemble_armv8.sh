#!/bin/bash
# To make executable command:
#   chmod +x assemble_armv8.sh
#   sudo cp ./assemble_armv8.sh /usr/bin/assemblev8
# Once done, simply execute as:
# $ assemblev8 [source file] [executable name]
aarch64-linux-gnu-as -o a.o $1
aarch64-linux-gnu-gcc -static -o $2 a.o
rm a.o # comment out if you don't want the intermidiate binary deleted every build