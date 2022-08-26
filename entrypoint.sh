#!/bin/sh

export PATH=${PATH}:/compiler/ido5.3

mkdir -p /output

echo "Compiling /input/code.c to /output/code.o..."
cc \
    -c -G 0 -Xfullwarn -Xcpluscomm -signed -nostdinc -non_shared -Wab,-r4300_mul \
    /input/code.c \
    -o /output/code.o

echo "Dumping /output/code.o... to /output/code.out"
mips-mti-elf-objdump \
    --disassemble \
    --disassemble-zeroes \
    --line-numbers \
    --reloc \
    --start-address=0 \
    /output/code.o | tee /output/code.out
