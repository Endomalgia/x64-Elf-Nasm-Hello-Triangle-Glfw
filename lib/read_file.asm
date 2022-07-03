;
; nasm -f elf64 *.asm
; gcc -m64 *.obj -o a.out
;

section .data
err_msg:		db	"READ FILE ERROR: file is either empty or doesnt exist", 0x0
err_msg_len:		db	$-err_msg

section .bss
stat_read_file:		resb	144

struc STAT_READ_FILE
    .st_dev         resq 1
    .st_ino         resq 1
    .st_nlink       resq 1
    .st_mode        resd 1
    .st_uid         resd 1
    .st_gid         resd 1
    .pad0           resb 4
    .st_rdev        resq 1
    .st_size        resq 1
    .st_blksize     resq 1
    .st_blocks      resq 1
    .st_atime       resq 1
    .st_atime_nsec  resq 1
    .st_mtime       resq 1
    .st_mtime_nsec  resq 1
    .st_ctime       resq 1
    .st_ctime_nsec  resq 1
endstruc

section .text
global read_file
read_file:
	push 	rbp


	mov	r12,	rsi ; Move the second argument (*buffer) into r12
	mov	rdi,	rdi ; Move the first argument (char* filename) into rdi


	mov	rsi,	stat_read_file
	; rdi already contains filename
	mov	rax,	0x4
	syscall				; Stat information from the file
	mov	r8,	QWORD [stat_read_file + STAT_READ_FILE.st_size] ; Store the file size in r8

	cmp	rax,	0
	jne file_is_empty		; Exit and print error if stat doesnt exit properly

	mov	rdx,	0
	mov	rsi,	0
	; rdi already contains filename
	mov	rax,	0x2
	syscall				; Open the file <filename>
	mov	r9,	rax		; Store the file descriptor in r9	


	mov	rdx,	r8
	mov	rsi,	r12
	mov	rdi,	r9
	mov	rax,	0x0
	syscall				; Read the file into <buffer>


	mov	rdi,	r9
	mov	rax,	0x3
	syscall				; Close the file

	;mov	rdx,	r8
	;mov	rsi,	r12
	;mov	rdi,	1
	;mov	rax,	0x1
	;syscall			; Print the buffer


	mov	rax,	r8		; Return the buffer into rax
	

	pop rbp
	ret

file_is_empty:

	mov	rdx,	err_msg_len
	mov	rsi,	err_msg
	mov	rdi,	1
	mov	rax,	0x1
	syscall				; Print the error message

	pop	rbp
	ret
