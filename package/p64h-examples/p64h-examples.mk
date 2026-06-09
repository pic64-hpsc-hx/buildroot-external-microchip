################################################################################
#
# p64h-examples: Linux userland demo applications for PIC64-HPSC-HX SoC.
#
################################################################################

P64H_EXAMPLES_BUILD_DIR = $(BUILD_DIR)/p64h-$(P64H_VERSION)
P64H_EXAMPLES_DEPENDENCIES = p64h

# Target directory for the installation
P64H_EXAMPLES_TARGET_DIR = /opt/microchip

ifeq ($(BR2_PACKAGE_P64H_EXAMPLES_HELLO),y)
P64H_EXAMPLES_APP_LIST += hello
endif

ifeq ($(BR2_PACKAGE_P64H_EXAMPLES_UIO_SHAREDMEM),y)
P64H_EXAMPLES_APP_LIST += sharedmem
endif

ifeq ($(BR2_PACKAGE_P64H_EXAMPLES_SPW),y)
P64H_EXAMPLES_APP_LIST += spw
endif

ifeq ($(BR2_PACKAGE_P64H_EXAMPLES_COAP_PING),y)
P64H_EXAMPLES_APP_LIST += coap_ping
endif

ifeq ($(BR2_PACKAGE_P64H_EXAMPLES_COAP_PROXY),y)
P64H_EXAMPLES_APP_LIST += coap_proxy
endif

ifeq ($(BR2_PACKAGE_P64H_EXAMPLES_LMS_DUMP),y)
P64H_EXAMPLES_APP_LIST += lms_dump
endif

ifeq ($(BR2_PACKAGE_P64H_EXAMPLES_UTILS),y)
P64H_EXAMPLES_APP_LIST += utils
endif

ifeq ($(BR2_PACKAGE_P64H_EXAMPLES_TEST_AUTOMATION),y)
P64H_EXAMPLES_APP_LIST += test_automation
endif

ifeq ($(BR2_PACKAGE_P64H_EXAMPLES_IPC_TEST),y)
P64H_EXAMPLES_APP_LIST += ipc_test
endif

ifeq ($(BR2_PACKAGE_P64H_EXAMPLES_RPMI_RAS),y)
P64H_EXAMPLES_APP_LIST += rpmi_ras
endif

ifeq ($(BR2_PACKAGE_P64H_EXAMPLES_CACHE_UIO_TEST),y)
P64H_EXAMPLES_APP_LIST += cache_uio_test
endif

P64H_EXAMPLES_APP_LIST += tflite_runtime
P64H_EXAMPLES_APP_LIST += sysc_rpmi

# Invoke build stages
define P64H_EXAMPLES_BUILD_CMDS
	@mkdir -p $(TARGET_DIR)$(P64H_EXAMPLES_TARGET_DIR); \
	$(call P64H_EXAMPLES_BUILD)
endef

# Invoke install stages
define P64H_EXAMPLES_INSTALL_TARGET_CMDS
	$(call P64H_EXAMPLES_INSTALL)
	@$(foreach app,$(P64H_EXAMPLES_APP_LIST), \
		$(call P64H_EXAMPLES_INSTALL_$(call UPPERCASE,$(app))); \
	)
endef

# Generate post installation extra stages (used to build debian packages)
ifeq ($(P64H_DEBPKG_BUILD),1)
$(foreach app,$(P64H_EXAMPLES_APP_LIST), \
	$(eval P64H_EXAMPLES_POST_INSTALL_TARGET_HOOKS += P64H_EXAMPLES_DEBIAN_PACKAGE_BUILD_$(call UPPERCASE,$(app))); \
)
endif

$(eval $(generic-package))
