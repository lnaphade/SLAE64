; Filename: exec.nasm
; Author: SLAE64-14209

global _start

section .text

_start:

      push 0x3b                             ; syscall 59 = execve()
      pop rax                               ; RAX = 59                                                  
      cdq                                   ; RDX = 0                                                      
      movabs rbx,0x68732f6e69622f           ; "hs/nib/"                                                 
      push rbx                              ; push in the stack                                                  
      mov rdi,rsp                           ; RDI -> RSP ("hs/nib/")                                                 
      push 0x632d                           ; "c-"                                                   
      mov rsi,rsp                           ; RSI -> RSP ("c-")
      push rdx                              ; RDX = 0                                                  
      call 0x555555558087                   ; storing the command "whoami" into the stack                                                  
      push rsi                              ; RSI -> stack
      push rdi                              ; RDI -> stack
      mov rsi, rsp                          ; RSI (/bin/bash -c whoami) -> stack                                       
      syscall
