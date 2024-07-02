################################################################################
#
# p64h benchmarks install
#
################################################################################

# COREMARK
define P64H_BENCHMARKS_INSTALL_COREMARK
	$(INSTALL) -D -m 0755 -s --strip-program=$(TARGET_STRIP) $(@D)/examples/benchmarks/coremark/coremark.exe $(TARGET_DIR)$(P64H_BENCHMARKS_TARGET_DIR)/coremark/coremark.exe
	$(INSTALL) -D -m 0755 -s --strip-program=$(TARGET_STRIP) $(@D)/examples/benchmarks/coremark/coremark_8_threads.exe $(TARGET_DIR)$(P64H_BENCHMARKS_TARGET_DIR)/coremark/coremark_8_threads.exe
endef

# STREAM
define P64H_BENCHMARKS_INSTALL_STREAM
	$(INSTALL) -D -m 0755 -s --strip-program=$(TARGET_STRIP) $(@D)/examples/benchmarks/STREAM/stream_c.exe $(TARGET_DIR)$(P64H_BENCHMARKS_TARGET_DIR)/STREAM/stream_c.exe
endef

# HACC
define P64H_BENCHMARKS_INSTALL_HACC
	$(INSTALL) -D -m 0755 -s --strip-program=$(TARGET_STRIP) $(@D)/examples/benchmarks/hacc/HACCKernels $(TARGET_DIR)$(P64H_BENCHMARKS_TARGET_DIR)/hacc/HACCKernels
endef

# PERLIN
define P64H_BENCHMARKS_INSTALL_PERLIN
	$(INSTALL) -D -m 0755 -s --strip-program=$(TARGET_STRIP) $(@D)/examples/benchmarks/perlin/perlin $(TARGET_DIR)$(P64H_BENCHMARKS_TARGET_DIR)/perlin/perlin
	$(INSTALL) -D -m 0755 $(@D)/examples/benchmarks/perlin/run_perlin.sh $(TARGET_DIR)$(P64H_BENCHMARKS_TARGET_DIR)/perlin/run_perlin.sh
endef

# SPACEBENCH
define P64H_BENCHMARKS_INSTALL_SPACEBENCH
	$(INSTALL) -D -m 0755 -s --strip-program=$(TARGET_STRIP) $(@D)/examples/benchmarks/spacebench/spacebench $(TARGET_DIR)$(P64H_BENCHMARKS_TARGET_DIR)/spacebench/spacebench
	$(INSTALL) -D -m 0755 $(@D)/examples/benchmarks/spacebench/run_benchmarks.sh $(TARGET_DIR)$(P64H_BENCHMARKS_TARGET_DIR)/spacebench/run_benchmarks.sh
	$(call P64H_BENCHMARKS_INSTALL_OPENBLAS)
	$(call P64H_BENCHMARKS_INSTALL_LIBFORTRAN)
endef

# MICROBENCH
MICROBENCH_BENCHMARKS := CCa CCe CCh CCh_st CCl CCm CF1 CRd CRf CRm CS1 CS3 DP1d DP1f DPT DPTd DPcvt ED1 \
	EF EI EM1 EM5 MC MCS MD MI MIM MIM2 MIP ML2 ML2_BW_ld ML2_BW_ldst ML2_BW_st ML2_st MM MM_st M_Dyn STL2 STL2b STc

define P64H_BENCHMARKS_INSTALL_MICROBENCH
	$(INSTALL) -d -m 0755 $(TARGET_DIR)$(P64H_BENCHMARKS_TARGET_DIR)/microbench
	$(INSTALL) -D -m 0755 $(@D)/examples/benchmarks/microbench/run_benchmarks $(TARGET_DIR)$(P64H_BENCHMARKS_TARGET_DIR)/microbench/run_benchmarks
	$(foreach dir,$(MICROBENCH_BENCHMARKS), \
		$(INSTALL) -D -m 0755 -s --strip-program=$(TARGET_STRIP) $(@D)/examples/benchmarks/microbench/$(dir)/bench $(TARGET_DIR)$(P64H_BENCHMARKS_TARGET_DIR)/microbench/$(dir)/bench;
	)
endef

# HPEC CHALLENGE
HPEC_BENCHMARKS := cfar ct pm fdFir tdFir svd
# Dataset ID to include
HPEC_BENCHMARKS_1 := cfar ct pm fdFir tdFir svd
HPEC_BENCHMARKS_2 := pm svd
HPEC_BUILD_DIR = $(@D)/examples/benchmarks/hpec_challenge/kernelBenchmarks

define P64H_BENCHMARKS_INSTALL_HPEC_CHALLENGE
	$(INSTALL) -d -m 0755 $(TARGET_DIR)$(P64H_BENCHMARKS_TARGET_DIR)/hpec_challenge/kernelBenchmarks
	$(INSTALL) -D -m 0755 $(HPEC_BUILD_DIR)/run_benchmarks.sh $(TARGET_DIR)$(P64H_BENCHMARKS_TARGET_DIR)/hpec_challenge/kernelBenchmarks/run_benchmarks.sh
	
	$(foreach d, $(HPEC_BENCHMARKS), \
		$(INSTALL) -D -m 0755 -s --strip-program=$(TARGET_STRIP) $(HPEC_BUILD_DIR)/$(d)/$(d) $(TARGET_DIR)$(P64H_BENCHMARKS_TARGET_DIR)/hpec_challenge/kernelBenchmarks/$(d)/$(d); \
		$(INSTALL) -D -m 0755 -s --strip-program=$(TARGET_STRIP) $(HPEC_BUILD_DIR)/$(d)/$(d)Verify $(TARGET_DIR)$(P64H_BENCHMARKS_TARGET_DIR)/hpec_challenge/kernelBenchmarks/$(d)/$(d)Verify; \
		$(INSTALL) -d -m 0755 $(TARGET_DIR)$(P64H_BENCHMARKS_TARGET_DIR)/hpec_challenge/kernelBenchmarks/$(d)/data;
	)
	$(foreach d, $(HPEC_BENCHMARKS_1), \
		$(INSTALL) -m 0644 $(HPEC_BUILD_DIR)/$(d)/data/1*.dat $(TARGET_DIR)$(P64H_BENCHMARKS_TARGET_DIR)/hpec_challenge/kernelBenchmarks/$(d)/data/
	)
	$(foreach d, $(HPEC_BENCHMARKS_2), \
		$(INSTALL) -m 0644 $(HPEC_BUILD_DIR)/$(d)/data/2*.dat $(TARGET_DIR)$(P64H_BENCHMARKS_TARGET_DIR)/hpec_challenge/kernelBenchmarks/$(d)/data/
	)
endef

# HPCC
define P64H_BENCHMARKS_INSTALL_HPCC
	$(INSTALL) -D -m 0755 -s --strip-program=$(TARGET_STRIP) $(@D)/examples/benchmarks/hpcc/hpcc $(TARGET_DIR)$(P64H_BENCHMARKS_TARGET_DIR)/hpcc/hpcc
	$(INSTALL) -D -m 0755 $(@D)/examples/benchmarks/hpcc/_hpccinf.txt $(TARGET_DIR)$(P64H_BENCHMARKS_TARGET_DIR)/hpcc/hpccinf.txt
	$(INSTALL) -D -m 0755 $(@D)/examples/benchmarks/hpcc/run_hpcc $(TARGET_DIR)$(P64H_BENCHMARKS_TARGET_DIR)/hpcc/run_hpcc
	$(call P64H_BENCHMARKS_INSTALL_OPENBLAS)
	$(call P64H_BENCHMARKS_INSTALL_OPENMPI)
	$(call P64H_BENCHMARKS_INSTALL_LIBC)
	$(call P64H_BENCHMARKS_INSTALL_LIBFORTRAN)
endef

# OpenMPI
define P64H_BENCHMARKS_INSTALL_OPENMPI
	$(INSTALL) -D -m 0755 $(@D)/install/libs/openmpi/install/lib/libmpi.so.40.20.0 $(TARGET_DIR)/usr/lib/libmpi.so.40.20.0
	$(INSTALL) -D -m 0755 $(@D)/install/libs/openmpi/install/lib/libmpi.so.40 $(TARGET_DIR)/usr/lib/libmpi.so.40
	$(INSTALL) -D -m 0755 $(@D)/install/libs/openmpi/install/lib/libmpi.so $(TARGET_DIR)/usr/lib/libmpi.so
	$(INSTALL) -D -m 0755 $(@D)/install/libs/openmpi/install/lib/libopen-rte.so.40.20.0 $(TARGET_DIR)/usr/lib/libopen-rte.so.40.20.0
	$(INSTALL) -D -m 0755 $(@D)/install/libs/openmpi/install/lib/libopen-rte.so.40 $(TARGET_DIR)/usr/lib/libopen-rte.so.40
	$(INSTALL) -D -m 0755 $(@D)/install/libs/openmpi/install/lib/libopen-rte.so $(TARGET_DIR)/usr/lib/libopen-rte.so
	$(INSTALL) -D -m 0755 $(@D)/install/libs/openmpi/install/lib/libopen-pal.so.40.20.0 $(TARGET_DIR)/usr/lib/libopen-pal.so.40.20.0
	$(INSTALL) -D -m 0755 $(@D)/install/libs/openmpi/install/lib/libopen-pal.so.40 $(TARGET_DIR)/usr/lib/libopen-pal.so.40
	$(INSTALL) -D -m 0755 $(@D)/install/libs/openmpi/install/lib/libopen-pal.so $(TARGET_DIR)/usr/lib/libopen-pal.so
	$(INSTALL) -D -m 0755 $(@D)/install/libs/openmpi/install/bin/* $(TARGET_DIR)/usr/bin/
endef

# OpenBLAS
define P64H_BENCHMARKS_INSTALL_OPENBLAS
	$(INSTALL) -D -m 0755 $(@D)/install/libs/openblas/build/lib/libopenblas_x280p-r0.3.20.so $(TARGET_DIR)/usr/lib/libopenblas_x280p-r0.3.20.so
	$(INSTALL) -D -m 0755 $(@D)/install/libs/openblas/build/lib/libopenblas.so.0 $(TARGET_DIR)/usr/lib/libopenblas.so.0
endef

# libfortran
define P64H_BENCHMARKS_INSTALL_LIBFORTRAN
	$(INSTALL) -D -m 0755 -s --strip-program=$(TARGET_STRIP) $(RISCV_PATH)/sysroot/lib/libgfortran.so $(TARGET_DIR)/usr/lib
	$(INSTALL) -D -m 0755 -s --strip-program=$(TARGET_STRIP) $(RISCV_PATH)/sysroot/lib/libgfortran.so.5 $(TARGET_DIR)/usr/lib
	$(INSTALL) -D -m 0755 -s --strip-program=$(TARGET_STRIP) $(RISCV_PATH)/sysroot/lib/libgfortran.so.5.0.0 $(TARGET_DIR)/usr/lib
endef

# libc
define P64H_BENCHMARKS_INSTALL_LIBC
	$(INSTALL) -D -m 0755 $(RISCV_PATH)/sysroot/usr/lib/libc.so $(TARGET_DIR)/usr/lib
endef
