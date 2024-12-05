################################################################################
#
# p64h-libs: Build Debian Packages
#
################################################################################

# Build hpsc-libopenblas Debian package
define P64H_LIBS_DEBIAN_PACKAGE_BUILD_OPENBLAS
	$(call P64H_DEBIAN_PACKAGE_SETUP,$(@D)/debian_packages/hpsc-libopenblas) \
	mkdir -p -m 0775 $(P64H_DEB_DIR); \
	$(INSTALL) -D -m 0755 $(@D)/openblas/build/lib/libopenblas_x280p-r0.3.28.so $(P64H_DEB_DIR)/usr/lib/libopenblas_x280p-r0.3.28.so; \
	$(call P64H_DEBIAN_PACKAGE_BUILD)
endef

# Build hpsc-libopenmpi Debian package
define P64H_LIBS_DEBIAN_PACKAGE_BUILD_OPENMPI
	$(call P64H_DEBIAN_PACKAGE_SETUP,$(@D)/debian_packages/hpsc-libopenmpi)
	mkdir -p -m 0775 $(P64H_DEB_DIR)/usr/lib
	mkdir -p -m 0775 $(P64H_DEB_DIR)/usr/bin
	$(INSTALL) -D -m 0755 $(@D)/openmpi/install/lib/libmpi.so.40.20.0 $(P64H_DEB_DIR)/usr/lib/libmpi.so.40.20.0
	$(INSTALL) -D -m 0755 $(@D)/openmpi/install/lib/libopen-rte.so.40.20.0 $(P64H_DEB_DIR)/usr/lib/libopen-rte.so.40.20.0
	$(INSTALL) -D -m 0755 $(@D)/openmpi/install/lib/libopen-pal.so.40.20.0 $(P64H_DEB_DIR)/usr/lib/libopen-pal.so.40.20.0

	# copy the mpi binaries, except (all variants of) the mpiCC compiler
	$(INSTALL) -D -m 0755 $(@D)/openmpi/install/bin/mpi[!Ccf]* \
						  $(@D)/openmpi/install/bin/or* \
						  $(@D)/openmpi/install/bin/ompi?[!w]* \
						  $(P64H_DEB_DIR)/usr/bin/
	$(call P64H_DEBIAN_PACKAGE_BUILD)
endef

# Build hpsc-libgfortran Debian package
define P64H_LIBS_DEBIAN_PACKAGE_BUILD_LIBGFORTRAN
	$(call P64H_DEBIAN_PACKAGE_SETUP,$(@D)/debian_packages/hpsc-libgfortran)
	mkdir -p -m 0775 $(P64H_DEB_DIR)/usr/lib
	$(INSTALL) -D -m 0755 -s --strip-program=$(TARGET_STRIP) $(RISCV_PATH)/sysroot/lib/libgfortran.so.5.0.0 $(P64H_DEB_DIR)/usr/lib
	$(call P64H_DEBIAN_PACKAGE_BUILD)
endef

# Build hpsc-libc Debian package
define P64H_LIBS_DEBIAN_PACKAGE_BUILD_LIBC
	$(call P64H_DEBIAN_PACKAGE_SETUP,$(@D)/debian_packages/hpsc-libc)
	mkdir -p -m 0775 $(P64H_DEB_DIR)/usr/lib
	$(INSTALL) -D -m 0755 $(RISCV_PATH)/sysroot/usr/lib/libc.so $(P64H_DEB_DIR)/usr/lib
	$(call P64H_DEBIAN_PACKAGE_BUILD)
endef

# Build hpsc-libopenmp Debian package
define P64H_LIBS_DEBIAN_PACKAGE_BUILD_OPENMP
	$(call P64H_DEBIAN_PACKAGE_SETUP,$(@D)/debian_packages/hpsc-libopenmp) \
	$(INSTALL) -D -m 0755 $(BR2_ROOTFS_OVERLAY)/lib/libomp.so $(P64H_DEB_DIR)/lib/libomp.so; \
	$(call P64H_DEBIAN_PACKAGE_BUILD)
endef
