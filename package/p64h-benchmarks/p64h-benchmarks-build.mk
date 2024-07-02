################################################################################
#
# p64h benchmarks build
#
################################################################################

# This block checks if BUILD_FLAGS is not defined and sets default values accordingly.
ifeq ($(BUILD_FLAGS),)

ifeq ($(CROSS_COMPILE),)
	CROSS_COMPILE := $(RISCV_PATH)/bin/riscv64-unknown-linux-gnu-
endif

OPT_FLAGS := -O2 -Wall -Wno-unused-but-set-variable -Wno-unused-variable -mabi=lp64d \
			-march=rv64imafdcvh_zic64b_zicbop_zicboz_ziccamoa_ziccif_ziccrse_zicsr_zifencei_zihintntl_zihintpause_za64rs_zfh_zba_zbb_zbs_zkt_zvfh_sscofpmf_svinval_svnapot_xsfvfhbfmin_xsfvfnrclipxfqf_xsfvfwmaccqqq_xsfvqmaccqoq_zvl512b \
			-menable-experimental-extensions -mtune=sifive-7-series -mcpu=sifive-x280o

ifeq ($(OPT_FLAGS_VEC),)
	OPT_FLAGS_VEC := -O3 -funroll-loops -fno-builtin-memcpy -ffast-math
	OPT_FLAGS_VEC += -Rpass=loop-vectorize -Rpass-missed=loop-vectorize -Rpass-analysis=loop-vectorize
endif

CFLAGS := OPT_FLAGS_VEC="$(OPT_FLAGS_VEC)" OPT_FLAGS="$(OPT_FLAGS)"
TARGET := x280
BUILD_FLAGS := $(CFLAGS) CROSS_COMPILE="$(CROSS_COMPILE)" TARGET=$(TARGET)
endif

# COREMARK
define P64H_BENCHMARKS_BUILD_COREMARK
	$(MAKE) $(BUILD_FLAGS) -C $(@D)/examples/benchmarks/ coremark.benchmark
endef

# STREAM
define P64H_BENCHMARKS_BUILD_STREAM	
	$(MAKE) $(BUILD_FLAGS) -C $(@D)/examples/benchmarks/ STREAM.benchmark
endef

# HACC
define P64H_BENCHMARKS_BUILD_HACC
	$(MAKE) $(BUILD_FLAGS) -C $(@D)/examples/benchmarks/ hacc.benchmark
endef

# MICROBENCH
define P64H_BENCHMARKS_BUILD_MICROBENCH
	$(MAKE) $(BUILD_FLAGS) -C $(@D)/examples/benchmarks/ microbench.benchmark
endef

# HPCC
define P64H_BENCHMARKS_BUILD_HPCC
	$(MAKE) BUILDROOT_BUILD_DIR=$(BUILD_DIR) $(BUILD_FLAGS) -C $(@D)/examples/benchmarks/ hpcc.benchmark
endef

# HPEC CHALLENGE
define P64H_BENCHMARKS_BUILD_HPEC_CHALLENGE
	$(MAKE) $(BUILD_FLAGS) -C $(@D)/examples/benchmarks/ hpec_challenge/kernelBenchmarks.benchmark
endef

# PERLIN
define P64H_BENCHMARKS_BUILD_PERLIN
	$(MAKE) $(BUILD_FLAGS) -C $(@D)/examples/benchmarks/ perlin.benchmark
endef

# SPACEBENCH
define P64H_BENCHMARKS_BUILD_SPACEBENCH
	$(MAKE) $(BUILD_FLAGS) -C $(@D)/examples/benchmarks/ spacebench.benchmark
endef