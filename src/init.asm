section .text
global create_window
init:
	push	rbp

	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Initialize GLFW
	
	call glfwInit

	; Print error message if GLFW fails to init
	cmp	rax,	0			; If glfwInit returns 0(false)
	je failed_to_init_GLFW

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Pass window hints to GLFW

	mov	rsi,	ANTIALIASING
	mov	rdi,	GLFW_SAMPLES
	call glfwWindowHint			; Hint the antialiazing

	mov	rsi,	OPENGL_VERSION_MAJOR
	mov	rdi,	GLFW_CONTEXT_VERSION_MAJOR
	call glfwWindowHint			; Hint the OpenGL ?.x version

	mov	rsi,	OPENGL_VERSION_MINOR
	mov	rdi,	GLFW_CONTEXT_VERSION_MINOR
	call glfwWindowHint			; Hint the OpenGL x.? version

	mov	rsi,	GLFW_OPENGL_CORE_PROFILE
	mov	rdi,	GLFW_OPENGL_PROFILE
	call glfwWindowHint			; Hint the OpenGL profile

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Create a GLFW window
	
	mov	r8,	NULL
	mov	rcx,	NULL
	mov	rdx,	WINDOW_NAME
	mov	rsi,	WINDOW_HEIGHT
	mov	rdi,	WINDOW_WIDTH
	call glfwCreateWindow	

	mov	qword [window_id],	rax	; Store the window_id in a variable

	; Print an error message if window=NULL
	cmp	qword [window_id],	NULL
	je window_is_null			; If the window is NULL then exit and show error

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Make the window the current GLFW context

	mov	rdi,	qword [window_id]
	call glfwMakeContextCurrent

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Initialize GLEW

	call glewInit

	; Print an error message if glewInit != 0
	cmp	rax,	0
	jne failed_to_init_GLEW			; Jump if anything but 0 is returned
		
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Set window input mode

	mov	rdx,	GL_TRUE
	mov	rsi,	GLFW_STICKY_KEYS
	mov	rdi,	qword [window_id]
	call glfwSetInputMode	

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	pop	rbp
	ret



failed_to_init_GLFW: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Print failed to init GLFW error and exit
	
	mov	rsi,	MSG_FAILED_TO_INIT_GLFW
	mov	rdi,	FMT_DEFAULT
	mov	rax,	1
	call printf				; Print the error message

	pop	rbp
	pop	rbp
	mov	rax,	-1			; Return -1
	ret

window_is_null:	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Print window is null error and exit
	
	mov	rsi,	MSG_GLFW_FAILED_TO_INIT_WINDOW
	mov	rdi,	FMT_DEFAULT
	mov	rax,	1
	call printf				; Print the error message

	call glfwTerminate			; Terminate GLFW

	pop	rbp				; Once for current function
	pop	rbp				; Twice for main function
	mov	rax,	-1			; Return -1
	ret

failed_to_init_GLEW: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Print failed to init GLEW error and exit
	
	mov	rsi,	MSG_FAILED_TO_INIT_GLEW
	mov	rdi,	FMT_DEFAULT
	mov	rax,	1
	call printf				; Print the error message

	pop	rbp
	pop	rbp
	mov	rax,	-1			; Return -1
	ret
