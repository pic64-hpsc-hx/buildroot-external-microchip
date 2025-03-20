################################################################################
#
# p64h-examples: Build
#
################################################################################

define P64H_EXAMPLES_BUILD
	. $(BUILD_DIR)/p64h-$(P64H_VERSION)/tools/bin/env.rc
	cmake -G Ninja -DXTOOLCHAIN=clang -DCMAKE_BUILD_TYPE=Release -DP64H_HW_EMU=1 -B $(P64H_EXAMPLES_BUILD_DIR)/examples/build $(P64H_EXAMPLES_BUILD_DIR)/examples
	ninja -C $(P64H_EXAMPLES_BUILD_DIR)/examples/build all
endef
