################################################################################
#
# p64h-examples: Build Debian Packages
#
################################################################################

# Build hpsc-hello Debian package
define P64H_EXAMPLES_DEBIAN_PACKAGE_BUILD_HELLO
	$(call P64H_DEBIAN_PACKAGE_SETUP,$(P64H_DEBPKG_SRC_DIR)/hpsc-hello) \
	mkdir -p -m 0775 $(P64H_DEB_DIR)/$(P64H_EXAMPLES_TARGET_DIR); \
	$(INSTALL) -D -m 0755 $(P64H_EXAMPLES_BUILD_DIR)/examples/build/hello/hello $(P64H_DEB_DIR)/$(P64H_EXAMPLES_TARGET_DIR); \
	$(call P64H_DEBIAN_PACKAGE_BUILD)
endef

# Build hpsc-uio-sharedmem Debian package
define P64H_EXAMPLES_DEBIAN_PACKAGE_BUILD_SHAREDMEM
	$(call P64H_DEBIAN_PACKAGE_SETUP,$(P64H_DEBPKG_SRC_DIR)/hpsc-uio-sharedmem) \
	mkdir -p -m 0775 $(P64H_DEB_DIR)/$(P64H_EXAMPLES_TARGET_DIR); \
	$(INSTALL) -D -m 0755 $(P64H_EXAMPLES_BUILD_DIR)/examples/build/sharedmem/sharedmem $(P64H_DEB_DIR)/$(P64H_EXAMPLES_TARGET_DIR); \
	$(call P64H_DEBIAN_PACKAGE_BUILD)
endef

# Build hpsc-uio-sharedmem Debian package
define P64H_EXAMPLES_DEBIAN_PACKAGE_BUILD_TFLITE_RUNTIME
        $(call P64H_DEBIAN_PACKAGE_SETUP,$(P64H_DEBPKG_SRC_DIR)/p64h-tflite-runtime-example) \
	$(INSTALL) -v -m755 -d $(P64H_DEB_DIR)/$(P64H_EXAMPLES_TARGET_DIR)/python/p64h-tflite-runtime-example; \
        $(INSTALL) -m 0755 $(wildcard $(P64H_EXAMPLES_BUILD_DIR)/examples/tflite_runtime/*) -t $(P64H_DEB_DIR)/$(P64H_EXAMPLES_TARGET_DIR)/python/p64h-tflite-runtime-example; \
        $(call P64H_DEBIAN_PACKAGE_BUILD)
endef

