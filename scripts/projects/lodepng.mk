build/lodepng/lodepng.o: build/hostroot/usr/bin/musl-gcc build/lodepng/lodepng.cpp
	@echo "  CC      $@"
	@$(REALCC) -o $@ -x c -fPIC -W -Wall -Wextra -ansi -pedantic -O3 -Wno-unused-function -c build/lodepng/lodepng.cpp
build/lodepng/liblodepng.a: build/lodepng/lodepng.o
	@echo "  AR      $@"
	@$(CROSS_COMPILE)ar cr $@ $^
	@$(CROSS_COMPILE)ranlib $@
build/lodepng/liblodepng.so: build/lodepng/lodepng.o
	@echo "  LD      $@"
	@$(REALCC) -o $@ -shared $^
build/sysroot/usr/lib/pkgconfig/lodepng.pc: build/lodepng/liblodepng.a build/lodepng/liblodepng.so
	@echo "prefix=$(SYSROOT)/usr" > $@
	@echo "exec_prefix=\$${prefix}" >> $@
	@echo "libdir=\$${exec_prefix}/lib" >> $@
	@echo "sharedlibdir=\$${libdir}" >> $@
	@echo "includedir=\$${prefix}/include" >> $@
	@echo >> $@
	@echo "Name: lodepng" >> $@
	@echo "Description: lodepng png image encoder decoder library" >> $@
	@echo "Version: 20210627" >> $@
	@echo >> $@
	@echo "Requires:" >> $@
	@echo "Libs: -L\$${libdir} -L\$${sharedlibdir} -llodepng" >> $@
	@echo "Cflags: -I\$${includedir}" >> $@
build/sysroot/usr/include/lodepng.h: build/lodepng/lodepng.h
	@$(INSTALL) -vDm755 $^ build/sysroot/usr/include
build/sysroot/usr/lib/liblodepng.a: build/lodepng/liblodepng.a
	@$(INSTALL) -vDm755 $^ build/sysroot/usr/lib
build/sysroot/usr/lib/liblodepng.so: build/lodepng/liblodepng.so
	@$(BIN_INSTALL) $^ build/sysroot/usr/lib
build-lodepng: build/lodepng/liblodepng.a build/lodepng/liblodepng.so
install-lodepng: build/sysroot/usr/lib/liblodepng.a build/sysroot/usr/lib/liblodepng.so build/sysroot/usr/include/lodepng.h build/sysroot/usr/lib/pkgconfig/lodepng.pc
clean-lodepng: build/lodepng/.git
	@cd $(shell dirname $<)&&git clean -xdf&&git reset --hard
.PHONY: clean-lodepng build-lodepng install-lodepng
