section .text
bind_vbuff:
	push	rbp

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Create and bind vertex array object

	mov	rsi,	vertex_array_id
	mov	rdi,	1
	call glGenVertexArrays			; Generate a vertex array

	mov	rdi,	qword [vertex_array_id]
	call glBindVertexArray			; Bind the vertex array

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Create and bind vertex buffer object

	mov	rsi,	vertex_buffer
	mov	rdi,	1
	call glGenBuffers			; Generate a new vertex buffer

	mov	rsi,	qword [vertex_buffer]
	mov	rdi,	GL_ARRAY_BUFFER
	call glBindBuffer			; Bind the buffer

	mov	rcx,	GL_STATIC_DRAW
	mov	rdx,	VERTEX_BUFFER_DATA
	mov	rsi,	VERTEX_BUFFER_DATA_LEN
	mov	rdi,	GL_ARRAY_BUFFER
	call glBufferData			; Bind the vertex data to the buffer

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	pop	rbp
	ret
