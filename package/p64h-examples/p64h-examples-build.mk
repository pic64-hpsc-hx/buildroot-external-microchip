################################################################################
#
# p64h-examples: Build
#
################################################################################

ifeq ($(PLATFORM),hwemu)
P64H_HW_EMU = "-DP64H_HW_EMU=1"
endif

define P64H_EXAMPLES_BUILD
	$(P64H_EXAMPLES_BUILD_DIR)/tools/bin/build.sh --build-examples --skip-buildroot -br p64h
endef
