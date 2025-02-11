################################################################################
#
# p64h-examples: Build
#
################################################################################

define P64H_EXAMPLES_BUILD_HELLO
	$(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" -C $(P64H_EXAMPLES_BUILD_DIR)/examples/hello;
endef

define P64H_EXAMPLES_BUILD_SHAREDMEM
	$(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" -C $(P64H_EXAMPLES_BUILD_DIR)/examples/sharedmem;
endef

define P64H_EXAMPLES_BUILD_UTILS
	. $(BUILD_DIR)/p64h-$(P64H_VERSION)/tools/bin/env.rc && \
	cmake -G Ninja -DXTOOLCHAIN=clang -DCMAKE_BUILD_TYPE=Release -DP64H_HW_EMU=1 -B $(P64H_EXAMPLES_BUILD_DIR)/examples/utils $(P64H_EXAMPLES_BUILD_DIR)/examples && cd $(P64H_EXAMPLES_BUILD_DIR)/examples/utils && ninja all;
endef
