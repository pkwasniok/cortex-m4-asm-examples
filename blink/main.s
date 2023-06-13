.cpu cortex-m4
.syntax unified
.thumb

.extern _stack_pointer

.section .vectors
__stack_pointer: .word _stack_pointer
__reset_handler: .word _reset+1

.section .text
_reset:
  bl init
  b main

main:
  bl led_on
  bl delay
  bl led_off
  bl delay

  b main

init:
  ldr r0, =0x40023830
  ldr r1, [r0]
  ldr r2, =0b1<<0
  orr r1, r2
  str r1, [r0]

  ldr r0, =0x40020000
  ldr r1, [r0]
  ldr r2, =0b01<<10
  orr r1, r2
  str r1, [r0]

  bx lr

led_off:
  ldr r0, =0x40020018
  ldr r1, =0b1<<21
  str r1, [r0]

  bx lr

led_on:
  ldr r0, =0x40020018
  ldr r1, =0b1<<5
  str r1, [r0]

  bx lr

delay:
  ldr r0, =5333333
  ldr r1, =0
  loop:
    add r1, #1
    cmp r1, r0
    ble loop
  bx lr
