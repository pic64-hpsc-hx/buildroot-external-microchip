################################################################################
#
# p64h-examples: Build Debian Packages
#
################################################################################

# Build hpsc-hello Debian package
define P64H_EXAMPLES_DEBIAN_PACKAGE_BUILD_HELLO
	$(call P64H_DEBIAN_PACKAGE_SETUP,$(@D)/debian_packages/hpsc-hello) \
	mkdir -p -m 0775 $(P64H_DEB_DIR)/$(P64H_EXAMPLES_TARGET_DIR); \
	$(INSTALL) -D -m 0755 $(@D)/examples/hello/hpsc_hello $(P64H_DEB_DIR)/$(P64H_EXAMPLES_TARGET_DIR); \
	$(call P64H_DEBIAN_PACKAGE_BUILD)
endef

# Build hpsc-uio-sharedmem Debian package
define P64H_EXAMPLES_DEBIAN_PACKAGE_BUILD_SHAREDMEM
	$(call P64H_DEBIAN_PACKAGE_SETUP,$(@D)/debian_packages/hpsc-uio-sharedmem) \
	mkdir -p -m 0775 $(P64H_DEB_DIR)/$(P64H_EXAMPLES_TARGET_DIR); \
	$(INSTALL) -D -m 0755 $(@D)/examples/sharedmem/hpsc_sharedmem $(P64H_DEB_DIR)/$(P64H_EXAMPLES_TARGET_DIR); \
	$(call P64H_DEBIAN_PACKAGE_BUILD)
endef