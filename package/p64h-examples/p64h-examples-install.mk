################################################################################
#
# p64h-examples: Install
#
################################################################################

define P64H_EXAMPLES_INSTALL
# The time_validation source (examples/time_validation) is excluded from some
# p64h-linux-examples releases (e.g. the public GitHub p64h-v*_dev tags), in
# which case it's never built. Skip installing it rather than unconditionally
# failing on a binary that doesn't exist.
if [ -f $(P64H_EXAMPLES_BUILD_DIR)/build/examples/time_validation/time_validation ]; then \
	rm -fr $(TARGET_DIR)$(P64H_EXAMPLES_TARGET_DIR)/time_validation; \
	$(INSTALL) -D -m 0755 $(P64H_EXAMPLES_BUILD_DIR)/build/examples/time_validation/time_validation $(TARGET_DIR)$(P64H_EXAMPLES_TARGET_DIR)/time_validation; \
else \
	echo "p64h-examples: skipping time_validation install -- source not present in this checkout"; \
fi
rm -fr $(TARGET_DIR)$(P64H_EXAMPLES_TARGET_DIR)/p64h_timer_example
$(INSTALL) -D -m 0755 $(P64H_EXAMPLES_BUILD_DIR)/build/examples/p64h_timer_example/p64h_timer_example $(TARGET_DIR)$(P64H_EXAMPLES_TARGET_DIR)/p64h_timer_example
rm -fr $(TARGET_DIR)$(P64H_EXAMPLES_TARGET_DIR)/appdma_basics_test
$(INSTALL) -D -m 0755 $(P64H_EXAMPLES_BUILD_DIR)/build/examples/appdma_test/appdma_basics_test $(TARGET_DIR)$(P64H_EXAMPLES_TARGET_DIR)//appdma_basics_test
rm -fr $(TARGET_DIR)$(P64H_EXAMPLES_TARGET_DIR)/cache_uio_test
$(INSTALL) -D -m 0755 $(P64H_EXAMPLES_BUILD_DIR)/build/examples/cache_uio_test/cache_uio_test $(TARGET_DIR)$(P64H_EXAMPLES_TARGET_DIR)/cache_uio_test
endef

define P64H_EXAMPLES_INSTALL_HELLO
	rm -rf $(TARGET_DIR)$(P64H_EXAMPLES_TARGET_DIR)/hpsc_hello
	$(INSTALL) -D -m 0755 $(P64H_EXAMPLES_BUILD_DIR)/build/examples/hello/hello $(TARGET_DIR)$(P64H_EXAMPLES_TARGET_DIR)/hpsc_hello
endef

define P64H_EXAMPLES_INSTALL_SHAREDMEM
	rm -rf $(TARGET_DIR)$(P64H_EXAMPLES_TARGET_DIR)/hpsc_sharedmem
	$(INSTALL) -D -m 0755 $(P64H_EXAMPLES_BUILD_DIR)/build/examples/sharedmem/sharedmem $(TARGET_DIR)$(P64H_EXAMPLES_TARGET_DIR)/hpsc_sharedmem
endef

# The utils source (examples/utils) is excluded from some p64h-linux-examples
# releases (e.g. the public GitHub p64h-v*_dev tags), in which case it's never
# built. Skip installing it rather than unconditionally failing on a binary
# that doesn't exist.
define P64H_EXAMPLES_INSTALL_UTILS
	if [ -f $(P64H_EXAMPLES_BUILD_DIR)/build/examples/utils/p64h_util ]; then \
		$(INSTALL) -D -m 0755 $(P64H_EXAMPLES_BUILD_DIR)/build/examples/utils/p64h_util  $(TARGET_DIR)/usr/bin; \
		ln -fs $(TARGET_DIR)/usr/bin/p64h_util  $(TARGET_DIR)/usr/bin/p64h_cp; \
	else \
		echo "p64h-examples: skipping utils install -- source not present in this checkout"; \
	fi
endef

define P64H_EXAMPLES_INSTALL_SPW
	rm -rf $(TARGET_DIR)$(P64H_EXAMPLES_TARGET_DIR)/spw
	$(INSTALL) -D -m 0755 $(P64H_EXAMPLES_BUILD_DIR)/build/examples/spw/spw $(TARGET_DIR)$(P64H_EXAMPLES_TARGET_DIR)/spw
endef

define P64H_EXAMPLES_INSTALL_COAP_PING
	rm -rf $(TARGET_DIR)$(P64H_EXAMPLES_TARGET_DIR)/coap_ping
	$(INSTALL) -D -m 0755 $(P64H_EXAMPLES_BUILD_DIR)/build/examples/coap_ping/coap_ping $(TARGET_DIR)$(P64H_EXAMPLES_TARGET_DIR)/coap_ping
endef

define P64H_EXAMPLES_INSTALL_COAP_PROXY
rm -rf $(TARGET_DIR)$(P64H_EXAMPLES_TARGET_DIR)/coap_proxy
    $(INSTALL) -D -m 0755 $(P64H_EXAMPLES_BUILD_DIR)/build/examples/coap_proxy/coap_proxy $(TARGET_DIR)$(P64H_EXAMPLES_TARGET_DIR)/coap_proxy
endef

define P64H_EXAMPLES_INSTALL_LMS_DUMP
	rm -rf $(TARGET_DIR)$(P64H_EXAMPLES_TARGET_DIR)/lms_dump
	$(INSTALL) -D -m 0755 $(P64H_EXAMPLES_BUILD_DIR)/build/examples/lms_dump/lms_dump $(TARGET_DIR)$(P64H_EXAMPLES_TARGET_DIR)/lms_dump
endef

define P64H_EXAMPLES_INSTALL_IPC_TEST
	rm -rf $(TARGET_DIR)$(P64H_EXAMPLES_TARGET_DIR)/ipc_test
	$(INSTALL) -D -m 0755 $(P64H_EXAMPLES_BUILD_DIR)/build/examples/ipc_test/ipc_test $(TARGET_DIR)$(P64H_EXAMPLES_TARGET_DIR)/ipc_test
endef

define P64H_EXAMPLES_INSTALL_CACHE_UIO_TEST
	rm -rf $(TARGET_DIR)$(P64H_EXAMPLES_TARGET_DIR)/cache_uio_test
	$(INSTALL) -D -m 0755 $(P64H_EXAMPLES_BUILD_DIR)/build/examples/cache_uio_test/cache_uio_test $(TARGET_DIR)$(P64H_EXAMPLES_TARGET_DIR)/cache_uio_test
endef

define P64H_EXAMPLES_INSTALL_TFLITE_RUNTIME
	rm -rf $(TARGET_DIR)$(P64H_EXAMPLES_TARGET_DIR)/tflite_runtime
	$(INSTALL) -v -m755 -d $(TARGET_DIR)$(P64H_EXAMPLES_TARGET_DIR)/python/p64h-tflite-runtime-example
	$(INSTALL) -m 0755 $(wildcard $(P64H_EXAMPLES_BUILD_DIR)/examples/tflite_runtime/*) -t $(TARGET_DIR)$(P64H_EXAMPLES_TARGET_DIR)/python/p64h-tflite-runtime-example
endef

define P64H_EXAMPLES_INSTALL_SYSC_RPMI
	rm -rf $(TARGET_DIR)$(P64H_EXAMPLES_TARGET_DIR)/sysc_rpmi
	$(INSTALL) -D -m 0755 $(P64H_EXAMPLES_BUILD_DIR)/build/examples/rpmi/sysc_rpmi/sysc_rpmi $(TARGET_DIR)$(P64H_EXAMPLES_TARGET_DIR)/sysc_rpmi
endef

define P64H_EXAMPLES_INSTALL_RPMI_RAS
	rm -rf $(TARGET_DIR)$(P64H_EXAMPLES_TARGET_DIR)/rpmi_ras
	$(INSTALL) -D -m 0755 $(P64H_EXAMPLES_BUILD_DIR)/build/examples/rpmi/rpmi_ras/rpmi_ras $(TARGET_DIR)$(P64H_EXAMPLES_TARGET_DIR)/rpmi_ras
endef

define P64H_EXAMPLES_INSTALL_TEST_AUTOMATION
	$(INSTALL) -m 0644 $(P64H_EXAMPLES_PKGDIR)/build_vars.txt $(TARGET_DIR)/etc/init.d/build_vars.txt
	$(INSTALL) -m 0755 $(P64H_EXAMPLES_PKGDIR)/S97buildvars $(TARGET_DIR)/etc/init.d/S97buildvars
	$(INSTALL) -d -m 0755 $(TARGET_DIR)$(P64H_EXAMPLES_TARGET_DIR)/app_runner
	$(INSTALL) -m 0644 $(P64H_EXAMPLES_BUILD_DIR)/examples/app_runner/* $(TARGET_DIR)$(P64H_EXAMPLES_TARGET_DIR)/app_runner/
endef
