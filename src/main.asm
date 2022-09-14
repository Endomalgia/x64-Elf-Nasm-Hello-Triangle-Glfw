;;
;; hello glfw
;;
;; Auth: Luna M, Hazel
;; Date: June 20, 3:38
;; Desc: Simple hello world for glfw :3
;;

; Externs
%include "externs/c_std.extern"		; C Standard Library
%include "externs/glfw.extern"		; GLFW
%include "externs/gl.extern"		; OpenGL
%include "externs/glew.extern"		; GLEW

; Internal Libraries
%include "lib/read_file.asm"

; Data files
%include "src/.macros"			; For important constants 
%include "src/.data"			; For initialized data
%include "src/.variables"		; For uninitialized variables

; Assembly files
%include "src/init.asm"
%include "src/bind_vbuff.asm"
%include "src/shaders.asm"
%include "src/loop.asm"

section .text
global _start
_start:

	; Initialize the Window, GLFW, and GLUT
	call init

	; Compile shaders and create+link program
	call compile_shaders
	
	; Bind Vertex buffer and Vertex array
	call bind_vbuff

	; Enter the main loop
	call loop

	; Exit and return 0
	mov	rdi,	0
	mov	rax,	0xE7
	syscall
