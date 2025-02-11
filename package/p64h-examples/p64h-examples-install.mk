################################################################################
#
# p64h-examples: Install
#
################################################################################

define P64H_EXAMPLES_INSTALL_HELLO
	rm -rf $(TARGET_DIR)$(P64H_EXAMPLES_TARGET_DIR)/hpsc_hello
	$(INSTALL) -D -m 0755 $(P64H_EXAMPLES_BUILD_DIR)/examples/hello/hpsc_hello $(TARGET_DIR)$(P64H_EXAMPLES_TARGET_DIR)/hpsc_hello
endef

define P64H_EXAMPLES_INSTALL_SHAREDMEM
	rm -rf $(TARGET_DIR)$(P64H_EXAMPLES_TARGET_DIR)/hpsc_sharedmem
	$(INSTALL) -D -m 0755 $(P64H_EXAMPLES_BUILD_DIR)/examples/sharedmem/hpsc_sharedmem $(TARGET_DIR)$(P64H_EXAMPLES_TARGET_DIR)/hpsc_sharedmem
endef

define P64H_EXAMPLES_INSTALL_UTILS
	$(INSTALL) -D -m 0755 $(P64H_EXAMPLES_BUILD_DIR)/examples/utils/utils/hpsc_util  $(TARGET_DIR)/usr/bin
	ln -fs /usr/bin/hpsc_util  $(TARGET_DIR)/usr/bin/hpsc_cp
endef

define P64H_EXAMPLES_INSTALL_TEST_AUTOMATION
	$(INSTALL) -m 0644 $(P64H_EXAMPLES_PKGDIR)build_vars.txt $(TARGET_DIR)/etc/init.d/build_vars.txt
	$(INSTALL) -m 0755 $(P64H_EXAMPLES_PKGDIR)S97buildvars $(TARGET_DIR)/etc/init.d/S97buildvars
	$(INSTALL) -d -m 0755 $(TARGET_DIR)$(P64H_EXAMPLES_TARGET_DIR)/app_runner
	$(INSTALL) -m 0644 $(P64H_EXAMPLES_BUILD_DIR)/examples/app_runner/* $(TARGET_DIR)$(P64H_EXAMPLES_TARGET_DIR)/app_runner/
endef