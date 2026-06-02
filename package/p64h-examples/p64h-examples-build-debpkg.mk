################################################################################
#
# p64h-examples: Build Debian Packages
#
################################################################################

# Build hello Debian package
define P64H_EXAMPLES_DEBIAN_PACKAGE_BUILD_HELLO
	$(call P64H_DEBIAN_PACKAGE_SETUP,$(P64H_DEBPKG_SRC_DIR)/hpsc-hello) \
	mkdir -p -m 0775 $(P64H_DEB_DIR)/$(P64H_EXAMPLES_TARGET_DIR); \
	$(INSTALL) -D -m 0755 $(P64H_EXAMPLES_BUILD_DIR)/build/examples/hello/hello $(P64H_DEB_DIR)/$(P64H_EXAMPLES_TARGET_DIR); \
	$(INSTALL) -D -m 0755 $(P64H_EXAMPLES_BUILD_DIR)/build/examples/rpmi/sysc_rpmi/sysc_rpmi $(P64H_DEB_DIR)/$(P64H_EXAMPLES_TARGET_DIR); \
	$(INSTALL) -D -m 0755 $(P64H_EXAMPLES_BUILD_DIR)/build/examples/rpmi/rpmi_ras/rpmi_ras $(P64H_DEB_DIR)/$(P64H_EXAMPLES_TARGET_DIR); \
	$(INSTALL) -D -m 0755 $(P64H_EXAMPLES_BUILD_DIR)/build/examples/time_validation/time_validation $(P64H_DEB_DIR)/$(P64H_EXAMPLES_TARGET_DIR); \
	$(INSTALL) -D -m 0755 $(P64H_EXAMPLES_BUILD_DIR)/build/examples/appdma_test/appdma_test $(P64H_DEB_DIR)/$(P64H_EXAMPLES_TARGET_DIR); \
	$(INSTALL) -D -m 0755 $(P64H_EXAMPLES_BUILD_DIR)/build/examples/cache_uio_test/cache_uio_test $(P64H_DEB_DIR)/$(P64H_EXAMPLES_TARGET_DIR); \
	$(INSTALL) -D -m 0755 $(P64H_EXAMPLES_BUILD_DIR)/install/bin/riscv64/rpmid $(P64H_DEB_DIR)/$(P64H_EXAMPLES_TARGET_DIR); \
	$(INSTALL) -D -m 0755 $(P64H_EXAMPLES_BUILD_DIR)/build/examples/rpmi/sysc_rpmid/sysc_rpmid $(P64H_DEB_DIR)/$(P64H_EXAMPLES_TARGET_DIR); \
	$(call P64H_DEBIAN_PACKAGE_BUILD)
endef

# Build sharedmem example Debian package
define P64H_EXAMPLES_DEBIAN_PACKAGE_BUILD_SHAREDMEM
	$(call P64H_DEBIAN_PACKAGE_SETUP,$(P64H_DEBPKG_SRC_DIR)/hpsc-uio-sharedmem) \
	mkdir -p -m 0775 $(P64H_DEB_DIR)/$(P64H_EXAMPLES_TARGET_DIR); \
	$(INSTALL) -D -m 0755 $(P64H_EXAMPLES_BUILD_DIR)/build/examples/sharedmem/sharedmem $(P64H_DEB_DIR)/$(P64H_EXAMPLES_TARGET_DIR); \
	$(call P64H_DEBIAN_PACKAGE_BUILD)
endef

# Build Tflite runtime Python example Debian package
define P64H_EXAMPLES_DEBIAN_PACKAGE_BUILD_TFLITE_RUNTIME
	$(call P64H_DEBIAN_PACKAGE_SETUP,$(P64H_DEBPKG_SRC_DIR)/p64h-tflite-runtime-example) \
	$(INSTALL) -v -m755 -d $(P64H_DEB_DIR)/$(P64H_EXAMPLES_TARGET_DIR)/python/p64h-tflite-runtime-example; \
	$(INSTALL) -m 0755 $(wildcard $(P64H_EXAMPLES_BUILD_DIR)/examples/tflite_runtime/*) -t $(P64H_DEB_DIR)/$(P64H_EXAMPLES_TARGET_DIR)/python/p64h-tflite-runtime-example; \
	$(call P64H_DEBIAN_PACKAGE_BUILD)
endef

