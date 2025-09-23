################################################################################
#
# p64h-examples: Install
#
################################################################################

define P64H_EXAMPLES_INSTALL_HELLO
	rm -rf $(TARGET_DIR)$(P64H_EXAMPLES_TARGET_DIR)/hpsc_hello
	$(INSTALL) -D -m 0755 $(P64H_EXAMPLES_BUILD_DIR)/examples/build/hello/hello $(TARGET_DIR)$(P64H_EXAMPLES_TARGET_DIR)/hpsc_hello
endef

define P64H_EXAMPLES_INSTALL_SHAREDMEM
	rm -rf $(TARGET_DIR)$(P64H_EXAMPLES_TARGET_DIR)/hpsc_sharedmem
	$(INSTALL) -D -m 0755 $(P64H_EXAMPLES_BUILD_DIR)/examples/build/sharedmem/sharedmem $(TARGET_DIR)$(P64H_EXAMPLES_TARGET_DIR)/hpsc_sharedmem
endef

define P64H_EXAMPLES_INSTALL_UTILS
	$(INSTALL) -D -m 0755 $(P64H_EXAMPLES_BUILD_DIR)/examples/build/utils/p64h_util  $(TARGET_DIR)/usr/bin
	ln -fs $(TARGET_DIR)/usr/bin/p64h_util  $(TARGET_DIR)/usr/bin/p64h_cp
endef

define P64H_EXAMPLES_INSTALL_SPW
	rm -rf $(TARGET_DIR)$(P64H_EXAMPLES_TARGET_DIR)/spw
	$(INSTALL) -D -m 0755 $(P64H_EXAMPLES_BUILD_DIR)/examples/build/spw/spw $(TARGET_DIR)$(P64H_EXAMPLES_TARGET_DIR)/spw
endef

define P64H_EXAMPLES_INSTALL_IPC_TEST
	rm -rf $(TARGET_DIR)$(P64H_EXAMPLES_TARGET_DIR)/ipc_test
	$(INSTALL) -D -m 0755 $(P64H_EXAMPLES_BUILD_DIR)/examples/build/ipc_test/ipc_test $(TARGET_DIR)$(P64H_EXAMPLES_TARGET_DIR)/ipc_test
endef

define P64H_EXAMPLES_INSTALL_TFLITE_RUNTIME
        rm -rf $(TARGET_DIR)$(P64H_EXAMPLES_TARGET_DIR)/tflite_runtime
        $(INSTALL) -v -m755 -d $(TARGET_DIR)$(P64H_EXAMPLES_TARGET_DIR)/python/p64h-tflite-runtime-example 
        $(INSTALL) -m 0755 $(wildcard $(P64H_EXAMPLES_BUILD_DIR)/examples/tflite_runtime/*) -t $(TARGET_DIR)$(P64H_EXAMPLES_TARGET_DIR)/python/p64h-tflite-runtime-example 
endef

define P64H_EXAMPLES_INSTALL_SYSC_RPMI
        rm -rf $(TARGET_DIR)$(P64H_EXAMPLES_TARGET_DIR)/sysc_rpmi
        $(INSTALL) -D -m 0755 $(P64H_EXAMPLES_BUILD_DIR)/examples/build/sysc_rpmi/sysc_rpmi $(TARGET_DIR)$(P64H_EXAMPLES_TARGET_DIR)/sysc_rpmi
endef

define P64H_EXAMPLES_INSTALL_TEST_AUTOMATION
	$(INSTALL) -m 0644 $(P64H_EXAMPLES_PKGDIR)build_vars.txt $(TARGET_DIR)/etc/init.d/build_vars.txt
	$(INSTALL) -m 0755 $(P64H_EXAMPLES_PKGDIR)S97buildvars $(TARGET_DIR)/etc/init.d/S97buildvars
	$(INSTALL) -d -m 0755 $(TARGET_DIR)$(P64H_EXAMPLES_TARGET_DIR)/app_runner
	$(INSTALL) -m 0644 $(P64H_EXAMPLES_BUILD_DIR)/examples/app_runner/* $(TARGET_DIR)$(P64H_EXAMPLES_TARGET_DIR)/app_runner/
endef