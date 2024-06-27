################################################################################
#
# p64h-examples: Linux userland demo applications for P64H SoC.
#
################################################################################

P64H_EXAMPLES_VERSION = main
P64H_EXAMPLES_SITE = "git@bitbucket.microchip.com:hpsc/p64h-linux-examples.git"
P64H_EXAMPLES_SITE_METHOD = git
P64H_EXAMPLES_LICENSE = MIT
P64H_EXAMPLES_LICENSE_FILES = LICENSE

# Target directory for the installation
P64H_EXAMPLES_TARGET_DIR = /opt/microchip

ifeq ($(BR2_PACKAGE_P64H_EXAMPLES_HELLO),y)
P64H_EXAMPLES_APP_LIST += hello
endif

ifeq ($(BR2_PACKAGE_P64H_EXAMPLES_SHAREDMEM),y)
P64H_EXAMPLES_APP_LIST += sharedmem
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
		$(call P64H_EXAMPLES_INSTALL_$(call UPPERCASE,$(app))) \
	)
endef

# Generate post installation extra stages (used to build debian packages)
ifeq ($(P64H_DEBPKG_BUILD),1)
@$(foreach app,$(P64H_EXAMPLES_APP_LIST), \
	$(eval P64H_EXAMPLES_POST_INSTALL_TARGET_HOOKS += P64H_EXAMPLES_DEBIAN_PACKAGE_BUILD_$(call UPPERCASE,$(app))) \
)
endif

$(eval $(generic-package))