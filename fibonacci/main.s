.cpu cortex-m4
.syntax unified
.thumb

.extern _stack_pointer

.section .vectors
__stack_pointer: .word _stack_pointer
__reset_handler: .word _reset+1

.section .text
_reset:
  mov r1, #6
  bl fibonacci

  b main

main:
  b main

fibonacci:
  push { r1, r2, lr }

  @ when n=0 return 0
  cmp r1, #0
  itt eq
  moveq r0, #0
  beq end

  @ when n=1 return 1
  cmp r1, #1
  itt eq
  moveq r0, #1
  beq end

  @ wehen n>1 calculate fibonacci(n-1)
  sub r1, #1
  bl fibonacci
  mov r2, r0

  @ when n>1 calculate fibonacci(n-2) and add to fibonacci(n-1)
  sub r1, #1
  bl fibonacci
  add r0, r2

  end:
    pop { r1, r2, lr }
    bx lr
