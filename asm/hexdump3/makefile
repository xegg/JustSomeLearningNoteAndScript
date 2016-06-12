hexdump3: hexdump3.o
	ld -o hexdump3 hexdump3.o ../textlib/textlib.o
hexdump3.o: hexdump3.asm
	nasm -f elf32 -g -F stabs hexdump3.asm
