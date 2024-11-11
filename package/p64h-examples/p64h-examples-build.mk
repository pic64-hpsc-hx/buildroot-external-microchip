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

define P64H_EXAMPLES_BUILD_UTILS
	cmake -G Ninja -DXTOOLCHAIN=clang -DCMAKE_BUILD_TYPE=Release -DP64H_HW_EMU=1 -B $(@D)/examples/utils $(@D)/examples && cd $(@D)/examples/utils && ninja all;
endef
