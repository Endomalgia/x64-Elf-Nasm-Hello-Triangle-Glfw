#!/bin/bash
PROJ_DIR=$(pwd)

ASM_FILE=$PROJ_DIR/src/main.asm
OBJ_FILE=$PROJ_DIR/obj/out.o
OUT_FILE=$PROJ_DIR/build/a.out

# Assembly the assembler source file with nasm
nasm -f elf64 $ASM_FILE -o $OBJ_FILE

# Exit the script if nasm executed improperly
if [ $(echo $?) != 0 ]; then exit; fi

# Link the obj file with gcc
gcc -m64 -no-pie -lGLEW -lGL -lglfw -lm $OBJ_FILE -o $OUT_FILE

# Exit the script if gcc executed improperly
if [ $(echo $?) != 0 ]; then exit; fi

# Execute the program
$OUT_FILE
