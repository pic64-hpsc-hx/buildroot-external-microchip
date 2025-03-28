################################################################################
#
# p64h-openmpi: OpenMPI Library for PIC64-HPSC-HX SoC.
#
################################################################################

P64H_OPENMPI_VERSION = v4.0.0
P64H_OPENMPI_SITE = https://github.com/open-mpi/ompi.git
P64H_OPENMPI_SITE_METHOD = git
P64H_OPENMPI_LICENSE = MIT
P64H_OPENMPI_LICENSE_FILES = LICENSE

export OPENMPI_BUILD_DIR=$(BUILD_DIR)/p64h-openmpi-$(P64H_OPENMPI_VERSION)/install

ifeq ($(RISCV_CLANG_FLAGS),)
RISCV_CLANG_FLAGS=-mcpu=sifive-x280 -march=rv64imafdch_zve64d_zicsr_zifencei_zic64b_zicbop_zicboz_ziccamoa_ziccif_ziccrse_zihintntl_zihintpause_zihpm_za64rs_zfh_zba_zbb_zbs_zkt_zvfh_smaia_zvl512b_xsfvfnrclipxfqf_xsfvfwmaccqqq_xsfvqmaccqoq -funsafe-math-optimizations -mabi=lp64d -mcmodel=medany
endif

define P64H_OPENMPI_CONFIGURE_CMDS
	export PATH=$(PATH):$(BR2_TOOLCHAIN_EXTERNAL_PATH)/bin && \
	cd $(@D) && $(@D)/autogen.pl && \
    $(@D)/configure --enable-orterun-prefix-by-default CC=riscv64-unknown-linux-gnu-clang CXX=riscv64-unknown-linux-gnu-clang++ \
        --enable-script-wrapper-compilers --disable-mpi-fortran --enable-shared \
        --disable-dlopen --host=riscv64-unknown-linux --prefix=$(@D)/install \
        CFLAGS="$(RISCV_CLANG_FLAGS)" PERL=/usr/bin/perl CROSS_COMPILE=$(BR2_TOOLCHAIN_EXTERNAL_PATH)/bin/riscv64-unknown-linux-gnu-
endef

define P64H_OPENMPI_BUILD_CMDS
	export PATH=$(PATH):$(BR2_TOOLCHAIN_EXTERNAL_PATH)/bin && \
	make -C $(@D) -j10 && \
	make -C $(@D) install
endef

define P64H_OPENMPI_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/install/lib/libmpi.so.40.20.0 $(TARGET_DIR)/usr/lib/libmpi.so.40.20.0
	ln -fs libmpi.so.40.20.0 $(TARGET_DIR)/usr/lib/libmpi.so.40
	ln -fs libmpi.so.40.20.0 $(TARGET_DIR)/usr/lib/libmpi.so

	$(INSTALL) -D -m 0755 $(@D)/install/lib/libopen-rte.so.40.20.0 $(TARGET_DIR)/usr/lib/libopen-rte.so.40.20.0
	ln -fs libopen-rte.so.40.20.0 $(TARGET_DIR)/usr/lib/libopen-rte.so.40
	ln -fs libopen-rte.so.40.20.0 $(TARGET_DIR)/usr/lib/libopen-rte.so

	$(INSTALL) -D -m 0755 $(@D)/install/lib/libopen-pal.so.40.20.0 $(TARGET_DIR)/usr/lib/libopen-pal.so.40.20.0
	ln -fs libopen-pal.so.40.20.0 $(TARGET_DIR)/usr/lib/libopen-pal.so.40
	ln -fs libopen-pal.so.40.20.0 $(TARGET_DIR)/usr/lib/libopen-pal.so

	# copy the mpi binaries, except (all variants of) the mpiCC compiler
	$(INSTALL) -D -m 0755 $(@D)/install/bin/mpi[!Ccf]* \
						  $(@D)/install/bin/or* \
						  $(@D)/install/bin/ompi?[!w]* \
						  $(TARGET_DIR)/usr/bin/
endef


ifeq ($(P64H_DEBPKG_BUILD),1)
$(eval P64H_OPENMPI_POST_INSTALL_TARGET_HOOKS += P64H_DEBIAN_PACKAGE_BUILD_OPENMPI);
P64H_OPENMPI_DEPENDENCIES = p64h
endif

$(eval $(generic-package))