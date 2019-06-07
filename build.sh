#!/bin/bash
export WATCOM=/opt/watcom
export PATH=$WATCOM/binl:$PATH
export EDPATH=$WATCOM/eddat
export WIPFC=$WATCOM/wipfc
export INCLUDE=$WATCOM/h:$WATCOM/h/win
export LIB=$WATCOM/lib286:$WATCOM/lib286/dos

i686-w64-mingw32-gcc -m16 -c test.c -std=gnu99
ld -m elf_i386 -T win16_ne.ld test.o -o test_self.exe --nmagic
#strip test.o

#wasm -bt=windows -ms test2.asm
#wcl -s -zl -bcl=windows -c test.c
#wcl -bcl=windows test.o test2.o
