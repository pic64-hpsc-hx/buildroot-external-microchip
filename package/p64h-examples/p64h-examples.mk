################################################################################
#
# p64h-examples: Linux userland demo applications for PIC64-HPSC-HX SoC.
#
################################################################################

P64H_EXAMPLES_BUILD_DIR = $(BUILD_DIR)/p64h-$(P64H_VERSION)
P64H_EXAMPLES_DEPENDENCIES = hwloc libzlib p64h

# Target directory for the installation
P64H_EXAMPLES_TARGET_DIR = /opt/microchip

ifeq ($(BR2_PACKAGE_P64H_EXAMPLES_HELLO),y)
P64H_EXAMPLES_APP_LIST += hello
endif

ifeq ($(BR2_PACKAGE_P64H_EXAMPLES_UIO_SHAREDMEM),y)
P64H_EXAMPLES_APP_LIST += sharedmem
endif

ifeq ($(BR2_PACKAGE_P64H_EXAMPLES_UTILS),y)
P64H_EXAMPLES_APP_LIST += utils
endif

ifeq ($(BR2_PACKAGE_P64H_EXAMPLES_TEST_AUTOMATION),y)
P64H_EXAMPLES_APP_LIST += test_automation
endif

# Invoke build stages
define P64H_EXAMPLES_BUILD_CMDS
	@mkdir -p $(TARGET_DIR)$(P64H_EXAMPLES_TARGET_DIR); \
	$(foreach app,$(P64H_EXAMPLES_APP_LIST), \
		$(call P64H_EXAMPLES_BUILD_$(call UPPERCASE,$(app))) \
	)
endef

# Invoke install stages
define P64H_EXAMPLES_INSTALL_TARGET_CMDS
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