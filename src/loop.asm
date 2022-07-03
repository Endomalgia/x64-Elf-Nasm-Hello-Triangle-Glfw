section .text
global main_loop
loop:
	push	rbp

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Clear the screen and initialize the program

	mov	rdi,	GL_COLOR_BUFFER_BIT
	call glClear					; Clear the screen

	mov	rdi,	[program_id]
	call glUseProgram				; Use the program (the one with the shaders)
	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Draw to the screen

	mov	rdi,	0
	call glEnableVertexAttribArray

	mov	rsi,	[vertex_buffer]
	mov	rdi,	GL_ARRAY_BUFFER
	call glBindBuffer

	mov	r9,	NULL
	mov	r8,	0
	mov	rcx,	GL_FALSE
	mov	rdx,	GL_FLOAT
	mov	rsi,	3
	mov	rdi,	0
	call glVertexAttribPointer

	mov	rdx,	3
	mov	rsi,	0
	mov	rdi,	GL_TRIANGLES
	call glDrawArrays

	mov	rdi,	0
	call glDisableVertexAttribArray

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Swap buffers and poll events

	mov	rdi,	[window_id]
	call glfwSwapBuffers				; Swap draw and display buffer

	call glfwPollEvents				; Allows events like GetKet etc.. to function

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Close the window on esc or other exit

	mov	rsi,	GLFW_KEY_ESCAPE
	mov	rdi,	[window_id]
	call glfwGetKey					; Check if escape is being pressed

	cmp	rax,	GLFW_PRESS
	je close_window_GLFW				; Close the window if it is

	mov	rdi,	[window_id]
	call glfwWindowShouldClose			; Check if the window should close

	cmp	rax,	0
	jne close_window_GLFW				; Close the window if output isnt 0 (shouldnt close)

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	pop	rbp
	jmp loop					; Loop :3
	ret

close_window_GLFW: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Exit the main loop
	pop	rbp
	ret
