start: 
	$(MAKE) -C boot
	$(MAKE) -C kernel
	$(MAKE) os-image

os-image: boot/boot_sect.bin kernel/kernel.bin
	cat boot/boot_sect.bin kernel/kernel.bin > os-image

clean:
	$(MAKE) -C boot clean
	$(MAKE) -C kernel clean
	rm -f *.bin
	rm -f *.o