# Final disk image should be 143360 bytes

hello.dsk: hello.o65 Makefile
	cp hello.o65 hello.dsk
	dd if=/dev/zero of=empty bs=143326 count=1
	cat empty >> hello.dsk

hello.o65: hello.s
	xa -o hello.o65 hello.s
