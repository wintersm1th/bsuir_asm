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
  
  invoke printf, msg_input
  invoke scanf, input_fmt, input_source
  
  mov ebx, 0
  mov ecx, input_source
  
  main_loop:  
    mov al, byte [ecx]
    sub al, 'c'
    je inc_counter
    
    mov al, byte [ecx]
    sub al, 'd'
    je inc_counter
    
    mov al, 0
    or al, byte [ecx]
    je end_loop
    
    continue:
      inc ecx
      jmp main_loop
      
    inc_counter: 
      inc ebx
      jmp continue
      
  end_loop:
  
  mov dword [result], ebx
  
  invoke printf, output_fmt, [result]
  invoke getch
  invoke exit, 0

section '.data' data readable writeable
  msg_input db 'Source: ', 0
  input_fmt db '%s', 0
  
  output_fmt db 'Result: %d', 0
  result dd 0
  input_source db 100 dup(0)



