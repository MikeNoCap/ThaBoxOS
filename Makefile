start: 
	$(MAKE) -C boot
	$(MAKE) -C kernel
	$(MAKE) os-image

os-image: boot/boot_sect.bin kernel/kernel.bin
	cat boot/boot_sect.bin kernel/kernel.bin > os-image