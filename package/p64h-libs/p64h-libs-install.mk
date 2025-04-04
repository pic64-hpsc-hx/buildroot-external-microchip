################################################################################
#
# p64h-libs: Install
#
################################################################################

# libgfortran
define P64H_LIBS_INSTALL_LIBGFORTRAN
	$(INSTALL) -D -m 0755 -s --strip-program=$(TARGET_STRIP) $(BR2_TOOLCHAIN_EXTERNAL_PATH)/sysroot/lib/libgfortran.so.5.0.0 $(TARGET_DIR)/usr/lib
	ln -fs libgfortran.so.5.0.0 $(TARGET_DIR)/usr/lib/libgfortran.so
	ln -fs libgfortran.so $(TARGET_DIR)/usr/lib/libgfortran.so.5
endef

# libc
define P64H_LIBS_INSTALL_LIBC
	$(INSTALL) -D -m 0755 $(BR2_TOOLCHAIN_EXTERNAL_PATH)/sysroot/usr/lib/libc.so $(TARGET_DIR)/usr/lib
endef