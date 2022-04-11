# Automatically generate lists of sources using wildcards
C_SOURCES = $(wildcard kernel/*.c drivers/*.c memory/*.c)
HEADERS = $(wildcard kernel/*.h drivers/*.h memory/*.h)

# Convert the *.c filenames to *.o to give a list of object files to build
OBJ = $(C_SOURCES:.c=.o)

# Defaul build target
all:	os-image

# Run bochs to simulate booting of our code
run:	all
	sh run_bochs.sh

# This is the actual disk image that the computer loads
# which is the combination of our compiled bootsector and kernel
# $^ is substituted with all of the target 's dependancy files
os-image:	boot/boot_sect.bin kernel.bin
	cat $^ > os-image

# This builds the binary of our kernel from two object files :
# - the kernel_entry , which jumps to main () in our kernel
# - the compiled C kernel
# $@ is the target file
#ld -o $@ -Ttext 0x1000 $^ --oformat binary
#ld -T link.ld -o $@ $^
kernel.bin:	kernel/kernel_entry.o ${OBJ}
	ld -T link.ld -o $@ $^ --oformat binary

# Generic rule for compiling C code to an object file
# For simplicity , we assume C files depend on all header files
%.o:	%.c ${HEADERS}
	gcc -ffreestanding -c $< -o $@

# Assemble the kernel_entry
%.o:	%.asm
	nasm $< -f elf -o $@

%.bin:	%.asm
	nasm $< -f bin -I 'boot/' -o $@

clean:
	rm -rf *.bin os-image
	rm -rf kernel/*.o boot/*.bin drivers/*.o memory/*.o