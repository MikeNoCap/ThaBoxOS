start: kernel.bin

kernel.o: kernel.c
	gcc -ffreestanding -c kernel.c -o kernel.o

kernel_entry.o: kernel_entry.asm
	nasm -f elf64 kernel_entry.asm -o kernel_entry.o


kernel.bin: kernel_entry.o kernel.o
	ld -o kernel.bin -Ttext 0x1000 kernel_entry.o kernel.o --oformat binary

clean:
	rm -f *.bin
	rm -f *.o