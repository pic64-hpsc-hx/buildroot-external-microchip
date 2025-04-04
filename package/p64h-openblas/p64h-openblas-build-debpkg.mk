# Build hpsc-libopenblas Debian package
define P64H_DEBIAN_PACKAGE_BUILD_OPENBLAS
	$(call P64H_DEBIAN_PACKAGE_SETUP,$(P64H_DEBPKG_SRC_DIR)/hpsc-libopenblas) \
	mkdir -p -m 0775 $(P64H_DEB_DIR); \
	$(INSTALL) -D -m 0755 $(P64H_LIBS_BUILD_DIR)/openblas/install/lib/libopenblas_x280p-r0.3.28.so $(P64H_DEB_DIR)/usr/lib/libopenblas_x280p-r0.3.28.so; \
	$(call P64H_DEBIAN_PACKAGE_BUILD)
endef
