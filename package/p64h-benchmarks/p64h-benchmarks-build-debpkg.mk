################################################################################
#
# p64h-benchmarks: Build Debian Packages
#
################################################################################

define P64H_BENCHMARKS_DEBIAN_PACKAGE_BUILD_ATOMICS
	$(call P64H_DEBIAN_PACKAGE_SETUP,$(P64H_DEBPKG_SRC_DIR)/hpsc-atomics) \
	mkdir -p -m 0775 $(P64H_DEB_DIR)/$(P64H_BENCHMARKS_TARGET_DIR)/atomics; \
	$(INSTALL) -D -m 0755 $(P64H_BENCHMARKS_BUILD_DIR)/atomics/atomics_exe_pkg/arch_riscv64.memory_latency.C.pthread.0.read.0_amo_ldadd $(P64H_DEB_DIR)/$(P64H_BENCHMARKS_TARGET_DIR)/atomics/arch_riscv64.memory_latency.C.pthread.0.read.0_amo_ldadd; \
	$(INSTALL) -D -m 0755 $(P64H_BENCHMARKS_BUILD_DIR)/atomics/atomics_exe_pkg/autorun.sh $(P64H_DEB_DIR)/$(P64H_BENCHMARKS_TARGET_DIR)/atomics/autorun.sh; \
	$(INSTALL) -D -m 0755 $(P64H_BENCHMARKS_BUILD_DIR)/atomics/atomics_exe_pkg/hugepages_setup.sh $(P64H_DEB_DIR)/$(P64H_BENCHMARKS_TARGET_DIR)/atomics/hugepages_setup.sh; \
	$(INSTALL) -D -m 0755 $(P64H_BENCHMARKS_BUILD_DIR)/atomics/atomics_exe_pkg/run_atomics_hugepages.sh $(P64H_DEB_DIR)/$(P64H_BENCHMARKS_TARGET_DIR)/atomics/run_atomics_hugepages.sh; \
	$(INSTALL) -D -m 0755 $(P64H_BENCHMARKS_BUILD_DIR)/atomics/atomics_exe_pkg/run_read_test.sh $(P64H_DEB_DIR)/$(P64H_BENCHMARKS_TARGET_DIR)/atomics/run_read_test.sh; \
	$(INSTALL) -D -m 0644 $(P64H_BENCHMARKS_BUILD_DIR)/atomics/atomics_exe_pkg/PARAMETERS $(P64H_DEB_DIR)/$(P64H_BENCHMARKS_TARGET_DIR)/atomics/PARAMETERS
	$(call P64H_DEBIAN_PACKAGE_BUILD)
endef

define P64H_BENCHMARKS_DEBIAN_PACKAGE_BUILD_COREMARK
	$(call P64H_DEBIAN_PACKAGE_SETUP,$(P64H_DEBPKG_SRC_DIR)/hpsc-coremark) \
	mkdir -p -m 0775 $(P64H_DEB_DIR)/$(P64H_BENCHMARKS_TARGET_DIR); \
	$(INSTALL) -D -m 0755 -s --strip-program=$(TARGET_STRIP) $(P64H_BENCHMARKS_BUILD_DIR)/coremark/coremark.exe $(P64H_DEB_DIR)/$(P64H_BENCHMARKS_TARGET_DIR)/coremark/coremark.exe
	$(INSTALL) -D -m 0755 -s --strip-program=$(TARGET_STRIP) $(P64H_BENCHMARKS_BUILD_DIR)/coremark/coremark_8_threads.exe $(P64H_DEB_DIR)/$(P64H_BENCHMARKS_TARGET_DIR)/coremark/coremark_8_threads.exe
	$(call P64H_DEBIAN_PACKAGE_BUILD)
endef

define P64H_BENCHMARKS_DEBIAN_PACKAGE_BUILD_STREAM
	$(call P64H_DEBIAN_PACKAGE_SETUP,$(P64H_DEBPKG_SRC_DIR)/hpsc-stream) \
	mkdir -p -m 0775 $(P64H_DEB_DIR)/$(P64H_BENCHMARKS_TARGET_DIR); \
	$(INSTALL) -D -m 0755 -s --strip-program=$(TARGET_STRIP) $(P64H_BENCHMARKS_BUILD_DIR)/STREAM/stream_c.exe $(P64H_DEB_DIR)/$(P64H_BENCHMARKS_TARGET_DIR)/STREAM/stream_c.exe; \
	$(call P64H_DEBIAN_PACKAGE_BUILD)
endef

define P64H_BENCHMARKS_DEBIAN_PACKAGE_BUILD_HACC
	$(call P64H_DEBIAN_PACKAGE_SETUP,$(P64H_DEBPKG_SRC_DIR)/hpsc-hacc) \
	mkdir -p -m 0775 $(P64H_DEB_DIR)/$(P64H_BENCHMARKS_TARGET_DIR); \
	$(INSTALL) -D -m 0755 -s --strip-program=$(TARGET_STRIP) $(P64H_BENCHMARKS_BUILD_DIR)/hacc/HACCKernels $(P64H_DEB_DIR)/$(P64H_BENCHMARKS_TARGET_DIR)/hacc/HACCKernels; \
	$(call P64H_DEBIAN_PACKAGE_BUILD)
endef

define P64H_BENCHMARKS_DEBIAN_PACKAGE_BUILD_PERLIN
	$(call P64H_DEBIAN_PACKAGE_SETUP,$(P64H_DEBPKG_SRC_DIR)/hpsc-perlin) \
	mkdir -p -m 0775 $(P64H_DEB_DIR)/$(P64H_BENCHMARKS_TARGET_DIR); \
	mkdir -p -m 0775 $(P64H_DEB_DIR)/lib; \
	$(INSTALL) -D -m 0755 -s --strip-program=$(TARGET_STRIP) $(P64H_BENCHMARKS_BUILD_DIR)/perlin/perlin $(P64H_DEB_DIR)/$(P64H_BENCHMARKS_TARGET_DIR)/perlin/perlin; \
	$(INSTALL) -D -m 0755 $(P64H_BENCHMARKS_BUILD_DIR)/perlin/run_perlin.sh $(P64H_DEB_DIR)/$(P64H_BENCHMARKS_TARGET_DIR)/perlin/run_perlin.sh; \
	$(call P64H_DEBIAN_PACKAGE_BUILD)
endef

define P64H_BENCHMARKS_DEBIAN_PACKAGE_BUILD_SPACEBENCH
	$(call P64H_DEBIAN_PACKAGE_SETUP,$(P64H_DEBPKG_SRC_DIR)/hpsc-spacebench) \
	mkdir -p -m 0775 $(P64H_DEB_DIR)/$(P64H_BENCHMARKS_TARGET_DIR); \
	$(INSTALL) -D -m 0755 -s --strip-program=$(TARGET_STRIP) $(P64H_BENCHMARKS_BUILD_DIR)/spacebench/spacebench $(P64H_DEB_DIR)/$(P64H_BENCHMARKS_TARGET_DIR)/spacebench/spacebench; \
	$(INSTALL) -D -m 0755 $(P64H_BENCHMARKS_BUILD_DIR)/spacebench/run_benchmarks.sh $(P64H_DEB_DIR)/$(P64H_BENCHMARKS_TARGET_DIR)/spacebench/run_benchmarks.sh; \
	$(call P64H_DEBIAN_PACKAGE_BUILD)
endef

define P64H_BENCHMARKS_DEBIAN_PACKAGE_BUILD_MICROBENCH
	$(call P64H_DEBIAN_PACKAGE_SETUP,$(P64H_DEBPKG_SRC_DIR)/hpsc-microbench) \
	mkdir -p -m 0775 $(P64H_DEB_DIR)/$(P64H_BENCHMARKS_TARGET_DIR); \
	$(INSTALL) -d -m 0755 $(P64H_DEB_DIR)/$(P64H_BENCHMARKS_TARGET_DIR)/microbench; \
	$(INSTALL) -D -m 0755 $(P64H_BENCHMARKS_BUILD_DIR)/microbench/run_benchmarks $(P64H_DEB_DIR)/$(P64H_BENCHMARKS_TARGET_DIR)/microbench/run_benchmarks; \
	$(foreach dir,$(MICROBENCH_BENCHMARKS), \
		$(INSTALL) -D -m 0755 -s --strip-program=$(TARGET_STRIP) $(P64H_BENCHMARKS_BUILD_DIR)/microbench/$(dir)/bench $(P64H_DEB_DIR)/$(P64H_BENCHMARKS_TARGET_DIR)/microbench/$(dir)/bench;
	)
	$(call P64H_DEBIAN_PACKAGE_BUILD)
endef

define P64H_BENCHMARKS_DEBIAN_PACKAGE_BUILD_HPEC_CHALLENGE
	$(call P64H_DEBIAN_PACKAGE_SETUP,$(P64H_DEBPKG_SRC_DIR)/hpsc-hpec-challenge) \
	mkdir -p -m 0775 $(P64H_DEB_DIR)/$(P64H_BENCHMARKS_TARGET_DIR); \
	$(INSTALL) -d -m 0755 $(P64H_DEB_DIR)/$(P64H_BENCHMARKS_TARGET_DIR)/hpec_challenge/kernelBenchmarks
	$(INSTALL) -D -m 0755 $(HPEC_BUILD_DIR)/run_benchmarks.sh $(P64H_DEB_DIR)/$(P64H_BENCHMARKS_TARGET_DIR)/hpec_challenge/kernelBenchmarks/run_benchmarks.sh

	$(foreach d, $(HPEC_BENCHMARKS), \
		$(INSTALL) -D -m 0755 -s --strip-program=$(TARGET_STRIP) $(HPEC_BUILD_DIR)/$(d)/$(d) $(P64H_DEB_DIR)/$(P64H_BENCHMARKS_TARGET_DIR)/hpec_challenge/kernelBenchmarks/$(d)/$(d); \
		$(INSTALL) -D -m 0755 -s --strip-program=$(TARGET_STRIP) $(HPEC_BUILD_DIR)/$(d)/$(d)Verify $(P64H_DEB_DIR)/$(P64H_BENCHMARKS_TARGET_DIR)/hpec_challenge/kernelBenchmarks/$(d)/$(d)Verify; \
		$(INSTALL) -d -m 0755 $(P64H_DEB_DIR)/$(P64H_BENCHMARKS_TARGET_DIR)/hpec_challenge/kernelBenchmarks/$(d)/data;
	)
	$(foreach d, $(HPEC_BENCHMARKS_1), \
		$(INSTALL) -m 0644 $(HPEC_BUILD_DIR)/$(d)/data/1*.dat $(P64H_DEB_DIR)/$(P64H_BENCHMARKS_TARGET_DIR)/hpec_challenge/kernelBenchmarks/$(d)/data/
	)
	$(foreach d, $(HPEC_BENCHMARKS_2), \
		$(INSTALL) -m 0644 $(HPEC_BUILD_DIR)/$(d)/data/2*.dat $(P64H_DEB_DIR)/$(P64H_BENCHMARKS_TARGET_DIR)/hpec_challenge/kernelBenchmarks/$(d)/data/
	)
	$(call P64H_DEBIAN_PACKAGE_BUILD)
endef

define P64H_BENCHMARKS_DEBIAN_PACKAGE_BUILD_HPCC
	$(call P64H_DEBIAN_PACKAGE_SETUP,$(P64H_DEBPKG_SRC_DIR)/hpsc-hpc-challenge) \
	mkdir -p -m 0775 $(P64H_DEB_DIR)/$(P64H_BENCHMARKS_TARGET_DIR); \
	$(INSTALL) -D -m 0755 -s --strip-program=$(TARGET_STRIP) $(P64H_BENCHMARKS_BUILD_DIR)/hpcc/hpcc $(P64H_DEB_DIR)/$(P64H_BENCHMARKS_TARGET_DIR)/hpcc/hpcc
	$(INSTALL) -D -m 0755 $(P64H_BENCHMARKS_BUILD_DIR)/hpcc/_hpccinf.txt $(P64H_DEB_DIR)/$(P64H_BENCHMARKS_TARGET_DIR)/hpcc/hpccinf.txt
	$(INSTALL) -D -m 0755 $(P64H_BENCHMARKS_BUILD_DIR)/hpcc/run_hpcc $(P64H_DEB_DIR)/$(P64H_BENCHMARKS_TARGET_DIR)/hpcc/run_hpcc
	$(call P64H_DEBIAN_PACKAGE_BUILD)
endef

define P64H_BENCHMARKS_DEBIAN_PACKAGE_BUILD_ROOFLINE
	$(call P64H_DEBIAN_PACKAGE_SETUP,$(P64H_DEBPKG_SRC_DIR)/hpsc-roofline) \
	mkdir -p -m 0775 $(P64H_DEB_DIR)/$(P64H_BENCHMARKS_TARGET_DIR)/roofline; \
	cp -a $(P64H_BENCHMARKS_BUILD_DIR)/roofline/Empirical_Roofline_Tool-1.1.0 $(P64H_DEB_DIR)/$(P64H_BENCHMARKS_TARGET_DIR)/roofline/Empirical_Roofline_Tool-1.1.0
	$(call P64H_DEBIAN_PACKAGE_BUILD)
endef

define P64H_BENCHMARKS_DEBIAN_PACKAGE_BUILD_HPFEC
	$(call P64H_DEBIAN_PACKAGE_SETUP,$(P64H_DEBPKG_SRC_DIR)/hpsc-hpfec) \
	mkdir -p -m 0775 $(P64H_DEB_DIR)/$(P64H_BENCHMARKS_TARGET_DIR)/hpfec; \
	$(INSTALL) -D -m 0755 -s --strip-program=$(TARGET_STRIP) $(P64H_BENCHMARKS_BUILD_DIR)/hpfec/alhat/Composite/bench $(P64H_DEB_DIR)/$(P64H_BENCHMARKS_TARGET_DIR)/hpfec/bench
	$(call P64H_DEBIAN_PACKAGE_BUILD)
endef