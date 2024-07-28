################################################################################
#
# p64h-benchmarks: Build Debian Packages
#
################################################################################

define P64H_BENCHMARKS_DEBIAN_PACKAGE_BUILD_COREMARK
	$(call P64H_DEBIAN_PACKAGE_SETUP,$(@D)/debian_packages/hpsc-coremark) \
	mkdir -p -m 0775 $(P64H_DEB_DIR)/$(P64H_BENCHMARKS_TARGET_DIR); \
	$(INSTALL) -D -m 0755 -s --strip-program=$(TARGET_STRIP) $(@D)/examples/benchmarks/coremark/coremark.exe $(P64H_DEB_DIR)/$(P64H_BENCHMARKS_TARGET_DIR)/coremark/coremark.exe
	$(INSTALL) -D -m 0755 -s --strip-program=$(TARGET_STRIP) $(@D)/examples/benchmarks/coremark/coremark_8_threads.exe $(P64H_DEB_DIR)/$(P64H_BENCHMARKS_TARGET_DIR)/coremark/coremark_8_threads.exe
	$(call P64H_DEBIAN_PACKAGE_BUILD)
endef

define P64H_BENCHMARKS_DEBIAN_PACKAGE_BUILD_STREAM
	$(call P64H_DEBIAN_PACKAGE_SETUP,$(@D)/debian_packages/hpsc-stream) \
	mkdir -p -m 0775 $(P64H_DEB_DIR)/$(P64H_BENCHMARKS_TARGET_DIR); \
	$(INSTALL) -D -m 0755 -s --strip-program=$(TARGET_STRIP) $(@D)/examples/benchmarks/STREAM/stream_c.exe $(P64H_DEB_DIR)/$(P64H_BENCHMARKS_TARGET_DIR)/STREAM/stream_c.exe; \
	$(call P64H_DEBIAN_PACKAGE_BUILD)
endef

define P64H_BENCHMARKS_DEBIAN_PACKAGE_BUILD_HACC
	$(call P64H_DEBIAN_PACKAGE_SETUP,$(@D)/debian_packages/hpsc-hacc) \
	mkdir -p -m 0775 $(P64H_DEB_DIR)/$(P64H_BENCHMARKS_TARGET_DIR); \
	$(INSTALL) -D -m 0755 -s --strip-program=$(TARGET_STRIP) $(@D)/examples/benchmarks/hacc/HACCKernels $(P64H_DEB_DIR)/$(P64H_BENCHMARKS_TARGET_DIR)/hacc/HACCKernels; \
	$(call P64H_DEBIAN_PACKAGE_BUILD)
endef

define P64H_BENCHMARKS_DEBIAN_PACKAGE_BUILD_PERLIN
	$(call P64H_DEBIAN_PACKAGE_SETUP,$(@D)/debian_packages/hpsc-perlin) \
	mkdir -p -m 0775 $(P64H_DEB_DIR)/$(P64H_BENCHMARKS_TARGET_DIR); \
	mkdir -p -m 0775 $(P64H_DEB_DIR)/lib; \
	$(INSTALL) -D -m 0755 -s --strip-program=$(TARGET_STRIP) $(@D)/examples/benchmarks/perlin/perlin $(P64H_DEB_DIR)/$(P64H_BENCHMARKS_TARGET_DIR)/perlin/perlin; \
	$(INSTALL) -D -m 0755 $(@D)/examples/benchmarks/perlin/run_perlin.sh $(P64H_DEB_DIR)/$(P64H_BENCHMARKS_TARGET_DIR)/perlin/run_perlin.sh; \
	$(INSTALL) -D -m 0755 $(BR2_ROOTFS_OVERLAY)/lib/libomp.so $(P64H_DEB_DIR)/lib/libomp.so; \
	$(call P64H_DEBIAN_PACKAGE_BUILD)
endef

define P64H_BENCHMARKS_DEBIAN_PACKAGE_BUILD_SPACEBENCH
	$(call P64H_DEBIAN_PACKAGE_SETUP,$(@D)/debian_packages/hpsc-spacebench) \
	mkdir -p -m 0775 $(P64H_DEB_DIR)/$(P64H_BENCHMARKS_TARGET_DIR); \
	$(INSTALL) -D -m 0755 -s --strip-program=$(TARGET_STRIP) $(@D)/examples/benchmarks/spacebench/spacebench $(P64H_DEB_DIR)/$(P64H_BENCHMARKS_TARGET_DIR)/spacebench/spacebench; \
	$(INSTALL) -D -m 0755 $(@D)/examples/benchmarks/spacebench/run_benchmarks.sh $(P64H_DEB_DIR)/$(P64H_BENCHMARKS_TARGET_DIR)/spacebench/run_benchmarks.sh; \
	$(call P64H_DEBIAN_PACKAGE_BUILD)
endef

define P64H_BENCHMARKS_DEBIAN_PACKAGE_BUILD_MICROBENCH
	$(call P64H_DEBIAN_PACKAGE_SETUP,$(@D)/debian_packages/hpsc-microbench) \
	mkdir -p -m 0775 $(P64H_DEB_DIR)/$(P64H_BENCHMARKS_TARGET_DIR); \
	$(INSTALL) -d -m 0755 $(P64H_DEB_DIR)/$(P64H_BENCHMARKS_TARGET_DIR)/microbench; \
	$(INSTALL) -D -m 0755 $(@D)/examples/benchmarks/microbench/run_benchmarks $(P64H_DEB_DIR)/$(P64H_BENCHMARKS_TARGET_DIR)/microbench/run_benchmarks; \
	$(foreach dir,$(MICROBENCH_BENCHMARKS), \
		$(INSTALL) -D -m 0755 -s --strip-program=$(TARGET_STRIP) $(@D)/examples/benchmarks/microbench/$(dir)/bench $(P64H_DEB_DIR)/$(P64H_BENCHMARKS_TARGET_DIR)/microbench/$(dir)/bench;
	)
	$(call P64H_DEBIAN_PACKAGE_BUILD)
endef

define P64H_BENCHMARKS_DEBIAN_PACKAGE_BUILD_HPEC_CHALLENGE
	$(call P64H_DEBIAN_PACKAGE_SETUP,$(@D)/debian_packages/hpsc-hpec-challenge) \
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
	$(call P64H_DEBIAN_PACKAGE_SETUP,$(@D)/debian_packages/hpsc-hpc-challenge) \
	mkdir -p -m 0775 $(P64H_DEB_DIR)/$(P64H_BENCHMARKS_TARGET_DIR); \
	$(INSTALL) -D -m 0755 -s --strip-program=$(TARGET_STRIP) $(@D)/examples/benchmarks/hpcc/hpcc $(P64H_DEB_DIR)/$(P64H_BENCHMARKS_TARGET_DIR)/hpcc/hpcc
	$(INSTALL) -D -m 0755 $(@D)/examples/benchmarks/hpcc/_hpccinf.txt $(P64H_DEB_DIR)/$(P64H_BENCHMARKS_TARGET_DIR)/hpcc/hpccinf.txt
	$(INSTALL) -D -m 0755 $(@D)/examples/benchmarks/hpcc/run_hpcc $(P64H_DEB_DIR)/$(P64H_BENCHMARKS_TARGET_DIR)/hpcc/run_hpcc
	$(call P64H_DEBIAN_PACKAGE_BUILD)
endef
