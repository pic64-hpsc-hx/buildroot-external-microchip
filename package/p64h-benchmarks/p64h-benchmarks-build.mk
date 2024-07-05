################################################################################
#
# p64h benchmarks build
#
################################################################################

$(eval BR_FLAGS := BUILDROOT_BUILD_DIR=$(BUILD_DIR))

# COREMARK
define P64H_BENCHMARKS_BUILD_COREMARK
	$(MAKE) $(BR_FLAGS) -C $(@D)/examples/benchmarks/ coremark.benchmark
endef

# STREAM
define P64H_BENCHMARKS_BUILD_STREAM	
	$(MAKE) $(BR_FLAGS) -C $(@D)/examples/benchmarks/ STREAM.benchmark
endef

# HACC
define P64H_BENCHMARKS_BUILD_HACC
	$(MAKE) $(BR_FLAGS) -C $(@D)/examples/benchmarks/ hacc.benchmark
endef

# MICROBENCH
define P64H_BENCHMARKS_BUILD_MICROBENCH
	$(MAKE) $(BR_FLAGS) -C $(@D)/examples/benchmarks/ microbench.benchmark
endef

# HPCC
define P64H_BENCHMARKS_BUILD_HPCC
	$(MAKE) $(BR_FLAGS) -C $(@D)/examples/benchmarks/ hpcc.benchmark
endef

# HPEC CHALLENGE
define P64H_BENCHMARKS_BUILD_HPEC_CHALLENGE
	$(MAKE) $(BR_FLAGS) -C $(@D)/examples/benchmarks/ hpec_challenge/kernelBenchmarks.benchmark
endef

# PERLIN
define P64H_BENCHMARKS_BUILD_PERLIN
	$(MAKE) $(BR_FLAGS) -C $(@D)/examples/benchmarks/ perlin.benchmark
endef

# SPACEBENCH
define P64H_BENCHMARKS_BUILD_SPACEBENCH
	$(MAKE) $(BR_FLAGS) -C $(@D)/examples/benchmarks/ spacebench.benchmark
endef