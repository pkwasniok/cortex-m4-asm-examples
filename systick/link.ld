MEMORY {
  FLASH : ORIGIN = 0x08000000, LENGTH = 512K
  RAM : ORIGIN = 0x20000000, LENGTH = 128K
}

SECTIONS {
  .text : {
    KEEP(*(.vectors))
    *(.text*)
  } > FLASH
}

_stack_pointer = ORIGIN(RAM) + LENGTH(RAM);