#!/bin/bash
PROJ_DIR=$(dirname "$0")

ASM_FILE=$PROJ_DIR/src/main.asm
OBJ_FILE=$PROJ_DIR/obj/out.o
OUT_FILE=$PROJ_DIR/build/a.out

MAIN_LIB=/lib64/ld-linux-x86-64.so.2
GLEW_LIB=/usr/lib64/libGLEW.so
OPGL_LIB=/usr/lib64/libGL.so
GLFW_LIB=/usr/lib64/libglfw.so

# Make folders
mkdir -p $PROJ_DIR/obj
mkdir -p $PROJ_DIR/build

# Assembly the assembler source file with nasm
nasm -f elf64 $ASM_FILE -o $OBJ_FILE

# Exit if nasm executed improperly
if [ $(echo $?) != 0 ]; then exit; fi

# Dynamically link the obj file with ld
ld $OBJ_FILE -dynamic-linker $MAIN_LIB $GLEW_LIB $OPGL_LIB $GLFW_LIB -lc -m elf_x86_64 -o $OUT_FILE

# Exit if ld executed improperly
if [ $(echo $?) != 0 ]; then exit; fi

# Execute the program
$OUT_FILE

