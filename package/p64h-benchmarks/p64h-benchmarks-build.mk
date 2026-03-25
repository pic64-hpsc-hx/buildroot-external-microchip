################################################################################
#
# p64h benchmarks build
#
################################################################################

$(eval BR_FLAGS := ROOTFS_BUILD_DIR=$(BUILD_DIR) BUILDROOT_BUILD_DIR=$(BUILD_DIR))

# ATOMICS
define P64H_BENCHMARKS_BUILD_ATOMICS
	. $(BUILD_DIR)/p64h-$(P64H_VERSION)/tools/bin/env.rc && \
	$(MAKE) $(BR_FLAGS) -C $(P64H_BENCHMARKS_BUILD_DIR) atomics.benchmark
endef

# COREMARK
define P64H_BENCHMARKS_BUILD_COREMARK
	. $(BUILD_DIR)/p64h-$(P64H_VERSION)/tools/bin/env.rc && \
	$(MAKE) $(BR_FLAGS) -C $(P64H_BENCHMARKS_BUILD_DIR) coremark.benchmark
endef

# STREAM
define P64H_BENCHMARKS_BUILD_STREAM
	. $(BUILD_DIR)/p64h-$(P64H_VERSION)/tools/bin/env.rc && \
	$(MAKE) $(BR_FLAGS) -C $(P64H_BENCHMARKS_BUILD_DIR) STREAM.benchmark
endef

# HACC
define P64H_BENCHMARKS_BUILD_HACC
	. $(BUILD_DIR)/p64h-$(P64H_VERSION)/tools/bin/env.rc && \
	$(MAKE) $(BR_FLAGS) -C $(P64H_BENCHMARKS_BUILD_DIR) hacc.benchmark
endef

# MICROBENCH
define P64H_BENCHMARKS_BUILD_MICROBENCH
	. $(BUILD_DIR)/p64h-$(P64H_VERSION)/tools/bin/env.rc && \
	$(MAKE) $(BR_FLAGS) -C $(P64H_BENCHMARKS_BUILD_DIR) microbench.benchmark
endef

# HPCC
define P64H_BENCHMARKS_BUILD_HPCC
	. $(BUILD_DIR)/p64h-$(P64H_VERSION)/tools/bin/env.rc && \
	$(MAKE) $(BR_FLAGS) -C $(P64H_BENCHMARKS_BUILD_DIR) hpcc.benchmark
endef

# HPEC CHALLENGE
define P64H_BENCHMARKS_BUILD_HPEC_CHALLENGE
	. $(BUILD_DIR)/p64h-$(P64H_VERSION)/tools/bin/env.rc && \
	$(MAKE) $(BR_FLAGS) -C $(P64H_BENCHMARKS_BUILD_DIR) hpec_challenge/kernelBenchmarks.benchmark
endef

# PERLIN
define P64H_BENCHMARKS_BUILD_PERLIN
	. $(BUILD_DIR)/p64h-$(P64H_VERSION)/tools/bin/env.rc && \
	$(MAKE) $(BR_FLAGS) -C $(P64H_BENCHMARKS_BUILD_DIR) perlin.benchmark
endef

# SPACEBENCH
define P64H_BENCHMARKS_BUILD_SPACEBENCH
	. $(BUILD_DIR)/p64h-$(P64H_VERSION)/tools/bin/env.rc && \
	$(MAKE) $(BR_FLAGS) -C $(P64H_BENCHMARKS_BUILD_DIR) spacebench.benchmark
endef

# ROOFLINE
define P64H_BENCHMARKS_BUILD_ROOFLINE
	. $(BUILD_DIR)/p64h-$(P64H_VERSION)/tools/bin/env.rc && \
	$(MAKE) $(BR_FLAGS) -C $(P64H_BENCHMARKS_BUILD_DIR) roofline.benchmark
endef

# HPFEC
define P64H_BENCHMARKS_BUILD_HPFEC
	. $(BUILD_DIR)/p64h-$(P64H_VERSION)/tools/bin/env.rc && \
	$(MAKE) $(BR_FLAGS) -C $(P64H_BENCHMARKS_BUILD_DIR) hpfec.benchmark
endef