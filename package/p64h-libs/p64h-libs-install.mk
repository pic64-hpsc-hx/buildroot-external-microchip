################################################################################
#
# p64h-libs: Install
#
################################################################################

# OpenBLAS
define P64H_LIBS_INSTALL_OPENBLAS
	$(INSTALL) -D -m 0755 $(@D)/install/libs/openblas/build/lib/libopenblas_x280p-r0.3.20.so $(TARGET_DIR)/usr/lib/libopenblas_x280p-r0.3.20.so;
	ln -fs libopenblas_x280p-r0.3.20.so $(TARGET_DIR)/usr/lib/libopenblas.so.0;
endef

# OpenMPI
define P64H_LIBS_INSTALL_OPENMPI
	$(INSTALL) -D -m 0755 $(@D)/install/libs/openmpi/install/lib/libmpi.so.40.20.0 $(TARGET_DIR)/usr/lib/libmpi.so.40.20.0
	ln -fs libmpi.so.40.20.0 $(TARGET_DIR)/usr/lib/libmpi.so.40
	ln -fs libmpi.so.40.20.0 $(TARGET_DIR)/usr/lib/libmpi.so

	$(INSTALL) -D -m 0755 $(@D)/install/libs/openmpi/install/lib/libopen-rte.so.40.20.0 $(TARGET_DIR)/usr/lib/libopen-rte.so.40.20.0
	ln -fs libopen-rte.so.40.20.0 $(TARGET_DIR)/usr/lib/libopen-rte.so.40
	ln -fs libopen-rte.so.40.20.0 $(TARGET_DIR)/usr/lib/libopen-rte.so

	$(INSTALL) -D -m 0755 $(@D)/install/libs/openmpi/install/lib/libopen-pal.so.40.20.0 $(TARGET_DIR)/usr/lib/libopen-pal.so.40.20.0
	ln -fs libopen-pal.so.40.20.0 $(TARGET_DIR)/usr/lib/libopen-pal.so.40
	ln -fs libopen-pal.so.40.20.0 $(TARGET_DIR)/usr/lib/libopen-pal.so

	# copy the mpi binaries, except (all variants of) the mpiCC compiler
	$(INSTALL) -D -m 0755 $(@D)/install/libs/openmpi/install/bin/mpi[!Ccf]* \
						  $(@D)/install/libs/openmpi/install/bin/or* \
						  $(@D)/install/libs/openmpi/install/bin/ompi?[!w]* \
						  $(TARGET_DIR)/usr/bin/
endef

# libfortran
define P64H_LIBS_INSTALL_LIBFORTRAN
	$(INSTALL) -D -m 0755 -s --strip-program=$(TARGET_STRIP) $(RISCV_PATH)/sysroot/lib/libgfortran.so.5.0.0 $(TARGET_DIR)/usr/lib
	ln -fs libgfortran.so.5.0.0 $(TARGET_DIR)/usr/lib/libgfortran.so
	ln -fs libgfortran.so $(TARGET_DIR)/usr/lib/libgfortran.so.5
endef

# libc
define P64H_LIBS_INSTALL_LIBC
	$(INSTALL) -D -m 0755 $(RISCV_PATH)/sysroot/usr/lib/libc.so $(TARGET_DIR)/usr/lib
endef