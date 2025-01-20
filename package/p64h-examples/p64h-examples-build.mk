################################################################################
#
# p64h-examples: Build
#
################################################################################

define P64H_EXAMPLES_BUILD
	cmake -G Ninja -DXTOOLCHAIN=clang -DCMAKE_BUILD_TYPE=Release -DP64H_HW_EMU=1 -B $(@D)/examples/build $(@D)/examples
	ninja -C $(@D)/examples/build all
endef
