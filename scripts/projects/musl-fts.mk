build/musl-fts/configure: build/musl-fts/configure.ac build/musl-fts/bootstrap.sh
	@cd build/musl-fts;bash bootstrap.sh
build/musl-fts/Makefile: build/hostroot/usr/bin/musl-gcc build/musl-fts/configure $(MUSL_FTS_DEPS)
	@cd build/musl-fts;./configure \
		CC="$(REALCC)" \
		--host=$(TARGET) \
		--prefix=/usr \
		--enable-shared=false \
		--with-sysroot="$(SYSROOT)" \
		$(MUSL_FTS_CONFIGURE_FLAGS)
build/musl-fts/.built: build/hostroot/usr/bin/musl-gcc build/musl-fts/Makefile
	@$(MAKE) \
		-C build/musl-fts \
		PREFIX="/usr" \
		CC="$(REALCC)" \
		$(MUSL_FTS_BUILD_FLAGS)
	@touch $@
build/musl-fts/.installed: build/musl-fts/.built
	@$(MAKE) \
		-C build/musl-fts \
		PREFIX="/usr" \
		DESTDIR="$(SYSROOT)" \
		$(MUSL_FTS_INSTALL_FLAGS) \
		install
	@sed -i s,=/usr,=$(SYSROOT)/usr,g build/sysroot/usr/lib/pkgconfig/musl-fts.pc
	@touch $@
build/sysroot/usr/lib/libfts.a: build/musl-fts/.installed
configure-musl-fts: build/musl-fts/Makefile
build-musl-fts: build/musl-fts/.built
install-musl-fts: build/musl-fts/.installed
clean-musl-fts: build/musl-fts/.git
	@cd $(shell dirname $<)&&git clean -xdf&&git reset --hard
.PHONY: clean-musl-fts configure-musl-fts build-musl-fts install-musl-fts
