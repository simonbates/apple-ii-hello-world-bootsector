# Final disk image should be 143360 bytes

hello.dsk: hello.bin Makefile
	cp hello.bin hello.dsk
	dd if=/dev/zero of=empty_space bs=143323 count=1
	cat empty_space >> hello.dsk

hello.bin: hello.s
	xa -o hello.bin hello.s
