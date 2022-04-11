ASMs=$(wildcard *.asm)

boot_sect.bin: $(ASMs)
	nasm boot_sect.asm -o boot_sect.bin

clean:
	rm -f *.bin
	rm -f *.o