################################################################################
#
# p64h benchmarks install
#
################################################################################

# ATOMICS
define P64H_BENCHMARKS_INSTALL_ATOMICS
	$(INSTALL) -d -m 0755 $(TARGET_DIR)$(P64H_BENCHMARKS_TARGET_DIR)/atomics
	$(INSTALL) -D -m 0755 $(P64H_BENCHMARKS_BUILD_DIR)/atomics/atomics_exe_pkg/arch_riscv64.memory_latency.C.pthread.0.read.0_amo_ldadd $(TARGET_DIR)$(P64H_BENCHMARKS_TARGET_DIR)/atomics/arch_riscv64.memory_latency.C.pthread.0.read.0_amo_ldadd
	$(INSTALL) -D -m 0755 $(P64H_BENCHMARKS_BUILD_DIR)/atomics/atomics_exe_pkg/autorun.sh $(TARGET_DIR)$(P64H_BENCHMARKS_TARGET_DIR)/atomics/autorun.sh
	$(INSTALL) -D -m 0755 $(P64H_BENCHMARKS_BUILD_DIR)/atomics/atomics_exe_pkg/hugepages_setup.sh $(TARGET_DIR)$(P64H_BENCHMARKS_TARGET_DIR)/atomics/hugepages_setup.sh
	$(INSTALL) -D -m 0755 $(P64H_BENCHMARKS_BUILD_DIR)/atomics/atomics_exe_pkg/run_atomics_hugepages.sh $(TARGET_DIR)$(P64H_BENCHMARKS_TARGET_DIR)/atomics/run_atomics_hugepages.sh
	$(INSTALL) -D -m 0755 $(P64H_BENCHMARKS_BUILD_DIR)/atomics/atomics_exe_pkg/run_read_test.sh $(TARGET_DIR)$(P64H_BENCHMARKS_TARGET_DIR)/atomics/run_read_test.sh
	$(INSTALL) -D -m 0644 $(P64H_BENCHMARKS_BUILD_DIR)/atomics/atomics_exe_pkg/PARAMETERS $(TARGET_DIR)$(P64H_BENCHMARKS_TARGET_DIR)/atomics/PARAMETERS
endef

# COREMARK
define P64H_BENCHMARKS_INSTALL_COREMARK
	$(INSTALL) -D -m 0755 -s --strip-program=$(TARGET_STRIP) $(P64H_BENCHMARKS_BUILD_DIR)/coremark/coremark.exe $(TARGET_DIR)$(P64H_BENCHMARKS_TARGET_DIR)/coremark/coremark.exe
	$(INSTALL) -D -m 0755 -s --strip-program=$(TARGET_STRIP) $(P64H_BENCHMARKS_BUILD_DIR)/coremark/coremark_8_threads.exe $(TARGET_DIR)$(P64H_BENCHMARKS_TARGET_DIR)/coremark/coremark_8_threads.exe
endef

# STREAM
define P64H_BENCHMARKS_INSTALL_STREAM
	$(INSTALL) -D -m 0755 -s --strip-program=$(TARGET_STRIP) $(P64H_BENCHMARKS_BUILD_DIR)/STREAM/stream_c.exe $(TARGET_DIR)$(P64H_BENCHMARKS_TARGET_DIR)/STREAM/stream_c.exe
endef

# HACC
define P64H_BENCHMARKS_INSTALL_HACC
	$(INSTALL) -D -m 0755 -s --strip-program=$(TARGET_STRIP) $(P64H_BENCHMARKS_BUILD_DIR)/hacc/HACCKernels $(TARGET_DIR)$(P64H_BENCHMARKS_TARGET_DIR)/hacc/HACCKernels
endef

# PERLIN
define P64H_BENCHMARKS_INSTALL_PERLIN
	$(INSTALL) -D -m 0755 -s --strip-program=$(TARGET_STRIP) $(P64H_BENCHMARKS_BUILD_DIR)/perlin/perlin $(TARGET_DIR)$(P64H_BENCHMARKS_TARGET_DIR)/perlin/perlin
	$(INSTALL) -D -m 0755 $(P64H_BENCHMARKS_BUILD_DIR)/perlin/run_perlin.sh $(TARGET_DIR)$(P64H_BENCHMARKS_TARGET_DIR)/perlin/run_perlin.sh
endef

# SPACEBENCH
define P64H_BENCHMARKS_INSTALL_SPACEBENCH
	$(INSTALL) -D -m 0755 -s --strip-program=$(TARGET_STRIP) $(P64H_BENCHMARKS_BUILD_DIR)/spacebench/spacebench $(TARGET_DIR)$(P64H_BENCHMARKS_TARGET_DIR)/spacebench/spacebench
	$(INSTALL) -D -m 0755 $(P64H_BENCHMARKS_BUILD_DIR)/spacebench/run_benchmarks.sh $(TARGET_DIR)$(P64H_BENCHMARKS_TARGET_DIR)/spacebench/run_benchmarks.sh
endef

# MICROBENCH
MICROBENCH_BENCHMARKS := CCa CCe CCh CCh_st CCl CCm CF1 CRd CRf CRm CS1 CS3 DP1d DP1f DPT DPTd DPcvt ED1 \
	EF EI EM1 EM5 MC MCS MD MI MIM MIM2 MIP ML2 ML2_BW_ld ML2_BW_ldst ML2_BW_st ML2_st MM MM_st M_Dyn STL2 STL2b STc

define P64H_BENCHMARKS_INSTALL_MICROBENCH
	$(INSTALL) -d -m 0755 $(TARGET_DIR)$(P64H_BENCHMARKS_TARGET_DIR)/microbench
	$(INSTALL) -D -m 0755 $(P64H_BENCHMARKS_BUILD_DIR)/microbench/run_benchmarks $(TARGET_DIR)$(P64H_BENCHMARKS_TARGET_DIR)/microbench/run_benchmarks
	$(foreach dir,$(MICROBENCH_BENCHMARKS), \
		$(INSTALL) -D -m 0755 -s --strip-program=$(TARGET_STRIP) $(P64H_BENCHMARKS_BUILD_DIR)/microbench/$(dir)/bench $(TARGET_DIR)$(P64H_BENCHMARKS_TARGET_DIR)/microbench/$(dir)/bench;
	)
endef

# HPEC CHALLENGE
HPEC_BENCHMARKS := cfar ct pm fdFir tdFir svd
# Dataset ID to include
HPEC_BENCHMARKS_1 := cfar ct pm fdFir tdFir svd
HPEC_BENCHMARKS_2 := pm svd
HPEC_BUILD_DIR = $(P64H_BENCHMARKS_BUILD_DIR)/hpec_challenge/kernelBenchmarks

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
	$(INSTALL) -D -m 0755 -s --strip-program=$(TARGET_STRIP) $(P64H_BENCHMARKS_BUILD_DIR)/hpcc/hpcc $(TARGET_DIR)$(P64H_BENCHMARKS_TARGET_DIR)/hpcc/hpcc
	$(INSTALL) -D -m 0755 $(P64H_BENCHMARKS_BUILD_DIR)/hpcc/_hpccinf.txt $(TARGET_DIR)$(P64H_BENCHMARKS_TARGET_DIR)/hpcc/hpccinf.txt
	$(INSTALL) -D -m 0755 $(P64H_BENCHMARKS_BUILD_DIR)/hpcc/run_hpcc $(TARGET_DIR)$(P64H_BENCHMARKS_TARGET_DIR)/hpcc/run_hpcc
endef

# ROOFLINE
define P64H_BENCHMARKS_INSTALL_ROOFLINE
	$(INSTALL) -d -m 0755 $(TARGET_DIR)$(P64H_BENCHMARKS_TARGET_DIR)/roofline
	cp -a $(P64H_BENCHMARKS_BUILD_DIR)/roofline/Empirical_Roofline_Tool-1.1.0 $(TARGET_DIR)$(P64H_BENCHMARKS_TARGET_DIR)/roofline/Empirical_Roofline_Tool-1.1.0
endef

# HPFEC
define P64H_BENCHMARKS_INSTALL_HPFEC
	$(INSTALL) -d -m 0755 $(TARGET_DIR)$(P64H_BENCHMARKS_TARGET_DIR)/hpfec
	$(INSTALL) -D -m 0755 -s --strip-program=$(TARGET_STRIP) $(P64H_BENCHMARKS_BUILD_DIR)/hpfec/alhat/Composite/bench $(TARGET_DIR)$(P64H_BENCHMARKS_TARGET_DIR)/hpfec/bench
endef
