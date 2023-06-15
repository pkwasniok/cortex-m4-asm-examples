.cpu cortex-m4
.syntax unified
.thumb

.extern _stack_pointer

.section .vectors
__stack_pointer:          .word _stack_pointer
__reset_handler:          .word _reset+1
__HMI_handler:            .word 0
__HardFault_handler:      .word 0
__MemManage_handler:      .word 0
__BusFault_handler:       .word 0
__UsageFault_handler:     .word 0
                          .word 0
                          .word 0
                          .word 0
                          .word 0
__SVCall_handler:         .word 0
__DebugMonitor_handler:   .word 0
                          .word 0
__PendSV_handler:         .word 0
__Systick_handler:        .word _systick+1

.section .text
_reset:
  @ Set SysTick reload value
  ldr r0, =0xe000e014
  ldr r1, =15999999
  str r1, [r0]

  @ Enable GPIOA clock
  ldr r0, =0x40023830
  ldr r1, [r0]
  ldr r2, =0b1<<0
  orr r1, r2
  str r1, [r0]

  @ Set PA5 as output
  ldr r0, =0x40020000
  ldr r1, [r0]
  ldr r2, =0b01<<10
  orr r1, r2
  str r1, [r0]

  @ Enable SysTick timer and SysTick exception
  ldr r0, =0xe000e010
  ldr r1, [r0]
  ldr r2, =0b111<<0
  orr r1, r2
  str r1, [r0]

  b main

main:
  @ Check if SysTick flag is raised and if so, branch to flag handler
  cmp r5, #1
  it eq
  bleq systick_handler

  b main

systick_handler:
  @ Check current PA5 state and branch to corresponding section
  cmp r4, #0
  it eq
  beq on
  b off

  @ Turn PA5 high
  on:
    mov r4, #1
    ldr r0, =0x40020018
    ldr r1, =0b1<<5
    str r1, [r0]
    b end

  @ Turn PA5 low
  off:
    mov r4, #0
    ldr r0, =0x40020018
    ldr r1, =0b1<<21
    str r1, [r0]
    b end

  @ Return to main and lower SysTick flag
  end:
    mov r5, #0
    bx lr

_systick:
  @ Rise SysTick flag
  mov r5, #1

  bx lr
