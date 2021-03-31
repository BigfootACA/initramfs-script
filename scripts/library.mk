root/usr/lib/lib%.so:
	@mkdir -p root/usr/lib
	@$(BIN_INSTALL) $< $@
root/usr/lib/libc.so: build/sysroot/usr/lib/libc.so
root/usr/lib/libblkid.so: build/sysroot/usr/lib/libblkid.so root/usr/lib/libc.so
root/usr/lib/libbz2.so: build/sysroot/usr/lib/libbz2.so root/usr/lib/libc.so
root/usr/lib/libcom-err.so: lib/libcom-err.so root/usr/lib/libc.so
root/usr/lib/libe2p.so: lib/libe2p.so root/usr/lib/libc.so
root/usr/lib/libext2fs.so: lib/libext2fs.so root/usr/lib/libcom-err.so root/usr/lib/libc.so
root/usr/lib/libf2fs.so: lib/libf2fs.so root/usr/lib/libc.so
root/usr/lib/libfdisk.so: build/sysroot/usr/lib/libfdisk.so root/usr/lib/libuuid.so root/usr/lib/libblkid.so root/usr/lib/libc.so
root/usr/lib/libhistory.so: build/sysroot/usr/lib/libhistory.so root/usr/lib/libncursesw.so root/usr/lib/libc.so
root/usr/lib/libkmod.so: build/sysroot/usr/lib/libkmod.so root/usr/lib/liblzma.so root/usr/lib/libz.so root/usr/lib/libc.so
root/usr/lib/liblz4.so: build/sysroot/usr/lib/liblz4.so root/usr/lib/libc.so
root/usr/lib/liblzma.so: build/sysroot/usr/lib/liblzma.so root/usr/lib/libc.so
root/usr/lib/liblzo2.so: lib/liblzo2.so root/usr/lib/libc.so
root/usr/lib/libmagic.so: build/sysroot/usr/lib/libmagic.so root/usr/lib/liblzma.so root/usr/lib/libbz2.so root/usr/lib/libz.so root/usr/lib/libc.so
root/usr/lib/libmount.so: build/sysroot/usr/lib/libmount.so root/usr/lib/libblkid.so root/usr/lib/libc.so
root/usr/lib/libncursesw.so: build/sysroot/usr/lib/libncursesw.so root/usr/lib/libc.so
root/usr/lib/libntfs.so: lib/libntfs.so root/usr/lib/libc.so
root/usr/lib/libreadline.so: build/sysroot/usr/lib/libreadline.so root/usr/lib/libncursesw.so root/usr/lib/libc.so
root/usr/lib/libsmartcols.so: build/sysroot/usr/lib/libsmartcols.so root/usr/lib/libc.so
root/usr/lib/libuuid.so: build/sysroot/usr/lib/libuuid.so root/usr/lib/libc.so
root/usr/lib/libudev.so: build/sysroot/usr/lib/libudev.so root/usr/lib/libc.so
root/usr/lib/libz.so: build/sysroot/usr/lib/libz.so root/usr/lib/libc.so
root/usr/lib/libzstd.so: build/sysroot/usr/lib/libzstd.so root/usr/lib/liblz4.so root/usr/lib/liblzma.so root/usr/lib/libz.so root/usr/lib/libc.so
