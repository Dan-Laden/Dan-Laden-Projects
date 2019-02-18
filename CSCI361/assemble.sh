#!/bin/bash
# To make executable command:
#   chmod +X assemble.sh
#   sudo cp ./assemble.sh /usr/bin/assemble
# Once done, simply execute as:
# $ assemble [source file] [executable name]
arm-linux-gnueabi-as -o a.o $1
arm-linux-gnueabi-ld -o $2 a.o
rm a.o # comment out if you don't want the intermidiate binary deleted every build