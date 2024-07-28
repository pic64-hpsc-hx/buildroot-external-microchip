################################################################################
#
# p64h-benchmarks for PIC64-HPSC-HX SoC.
#
################################################################################

P64H_BENCHMARKS_SITE = $(P64H_TOPDIR)
P64H_BENCHMARKS_LICENSE = MIT
P64H_BENCHMARKS_LICENSE_FILES = LICENSE
P64H_BENCHMARKS_DEPENDENCIES = hwloc libzlib

# Target installation dir
P64H_BENCHMARKS_TARGET_DIR = /opt/microchip/benchmarks

P64H_BENCHMARKS_APP_LIST :=

ifeq ($(BR2_PACKAGE_P64H_BENCHMARKS_COREMARK),y)
P64H_BENCHMARKS_APP_LIST += coremark
endif

ifeq ($(BR2_PACKAGE_P64H_BENCHMARKS_STREAM),y)
P64H_BENCHMARKS_APP_LIST += STREAM
endif

ifeq ($(BR2_PACKAGE_P64H_BENCHMARKS_HACC),y)
P64H_BENCHMARKS_APP_LIST += hacc
endif

ifeq ($(BR2_PACKAGE_P64H_BENCHMARKS_MICROBENCH),y)
P64H_BENCHMARKS_APP_LIST += microbench
endif

ifeq ($(BR2_PACKAGE_P64H_BENCHMARKS_HPCC),y)
P64H_BENCHMARKS_APP_LIST += hpcc
endif

ifeq ($(BR2_PACKAGE_P64H_BENCHMARKS_HPEC_CHALLENGE),y)
P64H_BENCHMARKS_APP_LIST += hpec_challenge
endif

ifeq ($(BR2_PACKAGE_P64H_BENCHMARKS_SPACEBENCH),y)
P64H_BENCHMARKS_APP_LIST += spacebench
endif

ifeq ($(BR2_PACKAGE_P64H_BENCHMARKS_PERLIN),y)
P64H_BENCHMARKS_APP_LIST += perlin
endif


# Invoke build stages
define P64H_BENCHMARKS_BUILD_CMDS
	mkdir -p $(TARGET_DIR)$(P64H_BENCHMARKS_TARGET_DIR)
	$(foreach app,$(P64H_BENCHMARKS_APP_LIST), \
		$(call P64H_BENCHMARKS_BUILD_$(call UPPERCASE,$(app)))
	)
endef

# Invoke install stages
define P64H_BENCHMARKS_INSTALL_TARGET_CMDS
	$(foreach app,$(P64H_BENCHMARKS_APP_LIST), \
		$(call P64H_BENCHMARKS_INSTALL_$(call UPPERCASE,$(app)))
	)
endef

# Generate post installation extra stages (used to build debian packages)
ifeq ($(P64H_DEBPKG_BUILD),1)
$(foreach app,$(P64H_BENCHMARKS_APP_LIST), \
	$(eval P64H_BENCHMARKS_POST_INSTALL_TARGET_HOOKS += P64H_BENCHMARKS_DEBIAN_PACKAGE_BUILD_$(call UPPERCASE,$(app))); \
)
endif

$(eval $(generic-package))