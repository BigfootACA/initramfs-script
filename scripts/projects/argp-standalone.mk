build/argp-standalone/libtool: build/argp-standalone/Makefile
build/argp-standalone/Makefile: build/hostroot/usr/bin/musl-gcc build/argp-standalone/configure
	@cd build/argp-standalone;./configure \
		CC="$(REALCC)" \
		--host=$(TARGET) \
		--prefix=/usr \
		$(ARGP_STANDALONE_CONFIGURE_FLAGS)
build/argp-standalone/.built: build/hostroot/usr/bin/musl-gcc build/argp-standalone/Makefile
	@$(MAKE) \
		-C build/argp-standalone \
		PREFIX="/usr" \
		CC="$(REALCC)" \
		$(ARGP_STANDALONE_BUILD_FLAGS) \
		libargp.a
	@touch $@
build/argp-standalone/.installed: build/argp-standalone/.built
	@$(INSTALL) -vDm644 build/argp-standalone/libargp.a -t build/sysroot/usr/lib
	@$(INSTALL) -vDm644 build/argp-standalone/argp.h -t build/sysroot/usr/include
	@touch $@
build/sysroot/usr/lib/libargp.a: build/argp-standalone/.installed
configure-argp-standalone: build/argp-standalone/Makefile
build-argp-standalone: build/argp-standalone/.built
install-argp-standalone: build/argp-standalone/.installed
clean-argp-standalone: build/argp-standalone/.git
	@cd $(shell dirname $<)&&git clean -xdf&&git reset --hard
.PHONY: clean-argp-standalone configure-argp-standalone build-argp-standalone install-argp-standalone
