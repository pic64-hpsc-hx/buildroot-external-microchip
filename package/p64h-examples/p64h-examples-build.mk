################################################################################
#
# p64h-examples: Build
#
################################################################################

define P64H_EXAMPLES_BUILD_HELLO
	$(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" -C $(@D)/examples/hello;
endef

define P64H_EXAMPLES_BUILD_SHAREDMEM
	$(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" -C $(@D)/examples/sharedmem;
endef
