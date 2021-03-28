root/usr/lib/lib%.so:
	@mkdir -p root/usr/lib
	@install -vDm755 $< $@
root/usr/lib/libc.so: lib/libc.so
root/usr/lib/libblkid.so: lib/libblkid.so root/usr/lib/libintl.so root/usr/lib/libc.so
root/usr/lib/libbz2.so: lib/libbz2.so root/usr/lib/libc.so
root/usr/lib/libcom-err.so: lib/libcom-err.so root/usr/lib/libc.so
root/usr/lib/libe2p.so: lib/libe2p.so root/usr/lib/libc.so
root/usr/lib/libext2fs.so: lib/libext2fs.so root/usr/lib/libcom-err.so root/usr/lib/libc.so
root/usr/lib/libf2fs.so: lib/libf2fs.so root/usr/lib/libc.so
root/usr/lib/libhistory.so: lib/libhistory.so root/usr/lib/libncursesw.so root/usr/lib/libc.so
root/usr/lib/libintl.so: lib/libintl.so root/usr/lib/libc.so
root/usr/lib/libkmod.so: lib/libkmod.so root/usr/lib/liblzma.so root/usr/lib/libz.so root/usr/lib/libc.so
root/usr/lib/liblz4.so: lib/liblz4.so root/usr/lib/libc.so
root/usr/lib/liblzma.so: lib/liblzma.so root/usr/lib/libc.so
root/usr/lib/liblzo2.so: lib/liblzo2.so root/usr/lib/libc.so
root/usr/lib/libmagic.so: lib/libmagic.so root/usr/lib/liblzma.so root/usr/lib/libbz2.so root/usr/lib/libz.so root/usr/lib/libc.so
root/usr/lib/libmount.so: lib/libmount.so root/usr/lib/libblkid.so root/usr/lib/libintl.so root/usr/lib/libc.so
root/usr/lib/libncursesw.so: lib/libncursesw.so root/usr/lib/libc.so
root/usr/lib/libntfs.so: lib/libntfs.so root/usr/lib/libc.so
root/usr/lib/libreadline.so: lib/libreadline.so root/usr/lib/libncursesw.so root/usr/lib/libc.so
root/usr/lib/libsmartcols.so: lib/libsmartcols.so root/usr/lib/libintl.so root/usr/lib/libc.so
root/usr/lib/libuuid.so: lib/libuuid.so root/usr/lib/libintl.so root/usr/lib/libc.so
root/usr/lib/libz.so: lib/libz.so root/usr/lib/libc.so
