[bits 32]
[extern _start]

;mov esp, _sys_stack
call _start

jmp $