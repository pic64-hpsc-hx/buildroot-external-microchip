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
	mkdir -p $(STAGING_DIR)/opt/microchip/benchmarks/atomics
	$(INSTALL) -D -m 0755 $(P64H_BENCHMARKS_BUILD_DIR)/atomics/atomics_exe_pkg/run_atomics_hugepages.sh $(STAGING_DIR)/opt/microchip/benchmarks/atomics/run_atomics_hugepages.sh
	$(INSTALL) -D -m 0755 $(P64H_BENCHMARKS_BUILD_DIR)/atomics/atomics_exe_pkg/hugepages_setup.sh $(STAGING_DIR)/opt/microchip/benchmarks/atomics/hugepages_setup.sh
	$(INSTALL) -D -m 0755 $(P64H_BENCHMARKS_BUILD_DIR)/atomics/atomics_exe_pkg/run_read_test.sh $(STAGING_DIR)/opt/microchip/benchmarks/atomics/run_read_test.sh
	$(INSTALL) -D -m 0755 $(P64H_BENCHMARKS_BUILD_DIR)/atomics/atomics_exe_pkg/arch_riscv64.memory_latency.C.pthread.0.read.0_amo_ldadd $(STAGING_DIR)/opt/microchip/benchmarks/atomics/arch_riscv64.memory_latency.C.pthread.0.read.0_amo_ldadd
	$(INSTALL) -D -m 0644 $(P64H_BENCHMARKS_BUILD_DIR)/atomics/atomics_exe_pkg/PARAMETERS $(STAGING_DIR)/opt/microchip/benchmarks/atomics/PARAMETERS
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
	mkdir -p $(STAGING_DIR)/opt/microchip/benchmarks/roofline
	$(INSTALL) -D -m 0644 $(P64H_BENCHMARKS_BUILD_DIR)/roofline/config.microchip.hpsc.01.new $(STAGING_DIR)/opt/microchip/benchmarks/roofline/config.microchip.hpsc.01.new
	cp -a $(P64H_BENCHMARKS_BUILD_DIR)/roofline/Empirical_Roofline_Tool-1.1.0 $(STAGING_DIR)/opt/microchip/benchmarks/roofline/Empirical_Roofline_Tool-1.1.0
endef

# HPFEC
# hpfec.benchmark already skips gracefully when examples/benchmarks/hpfec is
# absent (excluded from some p64h-linux-examples releases). Mirror that here
# instead of unconditionally installing a binary that was never built.
define P64H_BENCHMARKS_BUILD_HPFEC
	. $(BUILD_DIR)/p64h-$(P64H_VERSION)/tools/bin/env.rc && \
	$(MAKE) $(BR_FLAGS) EIGEN_PATH=$(STAGING_DIR)/usr/include/eigen3 -C $(P64H_BENCHMARKS_BUILD_DIR) hpfec.benchmark
	if [ -f $(P64H_BENCHMARKS_BUILD_DIR)/hpfec/alhat/Composite/bench ]; then \
		mkdir -p $(STAGING_DIR)/opt/microchip/benchmarks/hpfec/data; \
		$(INSTALL) -D -m 0755 $(P64H_BENCHMARKS_BUILD_DIR)/hpfec/alhat/Composite/bench $(STAGING_DIR)/opt/microchip/benchmarks/hpfec/bench; \
		$(INSTALL) -D -m 0644 $(P64H_BENCHMARKS_BUILD_DIR)/hpfec/alhat/Composite/data/image.img $(STAGING_DIR)/opt/microchip/benchmarks/hpfec/data/image.img; \
		$(INSTALL) -D -m 0644 $(P64H_BENCHMARKS_BUILD_DIR)/hpfec/alhat/Composite/data/nav-packets-short.txt $(STAGING_DIR)/opt/microchip/benchmarks/hpfec/data/nav-packets-short.txt; \
	else \
		echo "p64h-benchmarks: skipping hpfec staging install -- source not present in this checkout"; \
	fi
endef