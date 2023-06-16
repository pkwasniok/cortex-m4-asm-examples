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
__Systick_handler:        .word 0

.section .text
_reset:
  @ Enable PWR
  ldr r0, =0x40023840
  ldr r1, [r0]
  ldr r2, =0b1<<28
  orr r1, r2
  str r1, [r0]

  @ Disable RTC write access
  ldr r0, =0x40007000
  ldr r1, [r0]
  ldr r2, =0b1<<8
  orr r1, r2
  str r1, [r0]

  @ Enable LSI oscillator
  ldr r0, =0x40023874
  ldr r1, [r0]
  ldr r2, =0b1<<0
  orr r1, r2
  str r1, [r0]

  @ Set RTC clock to LSI
  ldr r0, =0x40023870
  ldr r1, [r0]
  ldr r2, =0b10<<8
  orr r1, r2
  str r1, [r0]

  @ Enable RTC
  ldr r0, =0x40023870
  ldr r1, [r0]
  ldr r2, =0b1<<15
  orr r1, r2
  str r1, [r0]

  b main

main:
  b main
