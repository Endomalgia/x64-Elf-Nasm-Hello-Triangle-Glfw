section .data
	buffer:	db	"uwu", 0xa, 0x0

section .text
global print_str
print_str:
	push	rbp

	mov	rdx,	buffer
	mov	rsi,	5
	mov	rdi,	1
	mov	rax,	0x1
	syscall

	pop	rbp
	ret

print_str_calc_buffer_len:
	
