################################################################################
#
# p64h-libs: Install
#
################################################################################

# OpenBLAS
define P64H_LIBS_INSTALL_OPENBLAS
	$(INSTALL) -D -m 0755 $(P64H_LIBS_BUILD_DIR)/openblas/build/lib/libopenblas_x280p-r0.3.28.so $(TARGET_DIR)/usr/lib/libopenblas_x280p-r0.3.28.so;
	ln -fs libopenblas_x280p-r0.3.28.so $(TARGET_DIR)/usr/lib/libopenblas.so.0;
endef

# OpenMPI
define P64H_LIBS_INSTALL_OPENMPI
	$(INSTALL) -D -m 0755 $(P64H_LIBS_BUILD_DIR)/openmpi/install/lib/libmpi.so.40.20.0 $(TARGET_DIR)/usr/lib/libmpi.so.40.20.0
	ln -fs libmpi.so.40.20.0 $(TARGET_DIR)/usr/lib/libmpi.so.40
	ln -fs libmpi.so.40.20.0 $(TARGET_DIR)/usr/lib/libmpi.so

	$(INSTALL) -D -m 0755 $(P64H_LIBS_BUILD_DIR)/openmpi/install/lib/libopen-rte.so.40.20.0 $(TARGET_DIR)/usr/lib/libopen-rte.so.40.20.0
	ln -fs libopen-rte.so.40.20.0 $(TARGET_DIR)/usr/lib/libopen-rte.so.40
	ln -fs libopen-rte.so.40.20.0 $(TARGET_DIR)/usr/lib/libopen-rte.so

	$(INSTALL) -D -m 0755 $(P64H_LIBS_BUILD_DIR)/openmpi/install/lib/libopen-pal.so.40.20.0 $(TARGET_DIR)/usr/lib/libopen-pal.so.40.20.0
	ln -fs libopen-pal.so.40.20.0 $(TARGET_DIR)/usr/lib/libopen-pal.so.40
	ln -fs libopen-pal.so.40.20.0 $(TARGET_DIR)/usr/lib/libopen-pal.so

	# copy the mpi binaries, except (all variants of) the mpiCC compiler
	$(INSTALL) -D -m 0755 $(P64H_LIBS_BUILD_DIR)/openmpi/install/bin/mpi[!Ccf]* \
						  $(P64H_LIBS_BUILD_DIR)/openmpi/install/bin/or* \
						  $(P64H_LIBS_BUILD_DIR)/openmpi/install/bin/ompi?[!w]* \
						  $(TARGET_DIR)/usr/bin/
endef

# libgfortran
define P64H_LIBS_INSTALL_LIBGFORTRAN
	. $(BUILD_DIR)/p64h-$(P64H_VERSION)/tools/bin/env_local.rc && \
	$(INSTALL) -D -m 0755 -s --strip-program=$(TARGET_STRIP) $${RISCV_PATH}/sysroot/lib/libgfortran.so.5.0.0 $(TARGET_DIR)/usr/lib
	ln -fs libgfortran.so.5.0.0 $(TARGET_DIR)/usr/lib/libgfortran.so
	ln -fs libgfortran.so $(TARGET_DIR)/usr/lib/libgfortran.so.5
endef

# libc
define P64H_LIBS_INSTALL_LIBC
	. $(BUILD_DIR)/p64h-$(P64H_VERSION)/tools/bin/env.rc && \
	$(INSTALL) -D -m 0755 $${RISCV_PATH}/sysroot/usr/lib/libc.so $(TARGET_DIR)/usr/lib
endef