vectors.o:
	xtensa-esp32-elf-as --warn --fatal-warnings vectors.s -o vectors.o

so.o:
	xtensa-esp32-elf-gcc -Wall -O2 -ffreestanding -c so.c -o so.o

so.elf: so.o vectors.o
	xtensa-esp32-elf-ld -nostdlib -T so.ld vectors.o so.o -o so.elf

so.list: so.elf
	xtensa-esp32-elf-objdump -D so.elf > so.list

so.bin: so.elf
	xtensa-esp32-elf-objcopy so.elf so.bin -O binary

flash: all
	esptool.py --port /dev/ttyUSB0 write_flash -fm qio 0x00000 so.bin

all: so.bin
	xtensa-esp32-elf-objcopy so.elf so.bin -O binary

clean:
	if test -e "so.bin"; then rm so.bin; fi
	if test -e "so.elf"; then rm so.elf; fi
	if test -e "so.o"; then rm so.o; fi
	if test -e "vectors.o"; then rm vectors.o; fi
	if test -e "so.list"; then rm so.list; fi
