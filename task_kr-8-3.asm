format PE Console

include 'win32ax.inc'

section '.idata' data import readable
  library kernel, 'kernel32.dll', msvcrt, 'msvcrt.dll'
  import kernel, exit, 'ExitProcess'
  import msvcrt, \
    printf, 'printf', \
    getch, '_getch', \
    scanf, 'scanf'

section '.code' code readable executable
  entry $

  invoke printf, msg_intro

  invoke printf, msg_in_a
  invoke scanf, input_fmt, a

  invoke printf, msg_in_b
  invoke scanf, input_fmt, b
     
  stdcall solution, [a], [b]

  mov [result], eax

  invoke printf, output_fmt, [result]
  invoke getch
  invoke exit, 0

section '.data' data readable writeable
  input_fmt db '%d', 0
  msg_intro db 'Near call + args via stack', 0dh, 0ah, 0
  msg_in_a db 'A: ', 0
  msg_in_b db 'B: ', 0
  output_fmt db 'Result: %d', 0
  a dd ?
  b dd ?
  result dd 0

section '.funcs' code readable executable
  proc  solution, a:BYTE, b:BYTE    
    local b16:WORD
    mov al, [b]
    mov ah, 0
    mov [b16], ax
    
    mov al, [a]
    mul [a]

    mov ecx, eax
    
    mov al, [b]
    mul [b]
    
    mov dx, [b16]
    mul dx
    
    shl edx, 16
    or eax, edx

    or eax, ecx

    pop ebx
    pop ebx

    ret
  endp


