################################################################################
#
# p64h-libs: Build Debian Packages
#
################################################################################
# Build hpsc-libgfortran Debian package
define P64H_LIBS_DEBIAN_PACKAGE_BUILD_LIBGFORTRAN
	$(call P64H_DEBIAN_PACKAGE_SETUP,$(P64H_DEBPKG_SRC_DIR)/hpsc-libgfortran)
	mkdir -p -m 0775 $(P64H_DEB_DIR)/usr/lib
	. $(BUILD_DIR)/p64h-$(P64H_VERSION)/tools/bin/env.rc && \
	$(INSTALL) -D -m 0755 -s --strip-program=$(TARGET_STRIP) $(RISCV_PATH)/sysroot/lib/libgfortran.so.5.0.0 $(P64H_DEB_DIR)/usr/lib
	$(call P64H_DEBIAN_PACKAGE_BUILD)
endef

# Build hpsc-libc Debian package
define P64H_LIBS_DEBIAN_PACKAGE_BUILD_LIBC
	$(call P64H_DEBIAN_PACKAGE_SETUP,$(P64H_DEBPKG_SRC_DIR)/hpsc-libc)
	mkdir -p -m 0775 $(P64H_DEB_DIR)/usr/lib
	. $(BUILD_DIR)/p64h-$(P64H_VERSION)/tools/bin/env.rc && \
	$(INSTALL) -D -m 0755 $(RISCV_PATH)/sysroot/usr/lib/libc.so $(P64H_DEB_DIR)/usr/lib
	$(call P64H_DEBIAN_PACKAGE_BUILD)
endef

# Build hpsc-libopenmp Debian package
define P64H_LIBS_DEBIAN_PACKAGE_BUILD_OPENMP
	$(call P64H_DEBIAN_PACKAGE_SETUP,$(P64H_DEBPKG_SRC_DIR)/hpsc-libopenmp) \
	. $(BUILD_DIR)/p64h-$(P64H_VERSION)/tools/bin/env.rc && \
	$(INSTALL) -D -m 0755 $(RISCV_PATH)/sysroot/lib/libomp.so $(P64H_DEB_DIR)/lib/libomp.so; \
	$(call P64H_DEBIAN_PACKAGE_BUILD)
endef
