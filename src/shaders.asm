section .text
compile_shaders:
	push	rbp

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Create and compile the vertex shader

	mov	rdi,	GL_VERTEX_SHADER
	call glCreateShader			; Create a new vertex shader

	mov	qword [vertex_shader],	rax	; Move the shader id into vertex_shader

	mov	rcx,	NULL
	mov	rdx,	VERTEX_SHADER_TEXT
	mov	rsi,	1
	mov	rdi,	qword [vertex_shader]
	call glShaderSource			; Load the shader text into the new shader

	mov	rdi,	qword [vertex_shader]
	call glCompileShader			; Compile the vertex shader

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Create and compile the fragment shader

	mov	rdi,	GL_FRAGMENT_SHADER
	call glCreateShader			; Create a new fragment shader

	mov	qword [fragment_shader],	rax ; Move the shader id into fragment_shader

	mov	rcx,	NULL
	mov	rdx,	FRAGMENT_SHADER_TEXT
	mov	rsi,	1
	mov	rdi,	qword [fragment_shader]
	call glShaderSource			; Load the shader text into the new shader

	mov	rdi,	qword [fragment_shader]
	call glCompileShader			; Compile the fragment shader

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Create and link program

	call glCreateProgram			; Create a new program

	mov	qword [program_id],	rax	; Store the program id in program_id

	mov	rsi,	[vertex_shader]
	mov	rdi,	[program_id]
	call glAttachShader			; Attach the vertex shader

	mov	rsi,	[fragment_shader]
	mov	rdi,	[program_id]
	call glAttachShader			; Attach the fragment shader

	mov	rdi,	[program_id]
	call glLinkProgram			; Link the program

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Clean up the shaders

	mov	rdi,	[vertex_shader]
	call glDeleteShader

	mov	rdi,	[fragment_shader]
	call glDeleteShader

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	pop	rbp
	ret
