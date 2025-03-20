################################################################################
#
# p64h-examples: Build
#
################################################################################

define P64H_EXAMPLES_BUILD
	cmake -G Ninja -DXTOOLCHAIN=clang -DCMAKE_BUILD_TYPE=Release -DP64H_HW_EMU=1 -B $(P64H_EXAMPLES_BUILD_DIR)/examples/build $(P64H_EXAMPLES_BUILD_DIR)/examples
	ninja -C $(P64H_EXAMPLES_BUILD_DIR)/examples/build all
endef
