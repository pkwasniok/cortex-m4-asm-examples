firmware.bin: firmware.elf
	arm-none-eabi-objcopy -O binary build/firmware.elf build/firmware.bin

firmware.elf: main.o
	arm-none-eabi-gcc -nostdlib -T link.ld -o build/firmware.elf build/main.o

main.o:
	arm-none-eabi-as -g -o build/main.o main.s

flash:
	st-flash write build/firmware.bin 0x08000000

clean:
	rm -r build/*