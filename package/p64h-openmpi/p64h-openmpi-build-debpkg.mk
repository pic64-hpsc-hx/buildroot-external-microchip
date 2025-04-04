# Build hpsc-libopenmpi Debian package
define P64H_DEBIAN_PACKAGE_BUILD_OPENMPI
	$(call P64H_DEBIAN_PACKAGE_SETUP,$(P64H_DEBPKG_SRC_DIR)/hpsc-libopenmpi)
	mkdir -p -m 0775 $(P64H_DEB_DIR)/usr/lib
	mkdir -p -m 0775 $(P64H_DEB_DIR)/usr/bin
	$(INSTALL) -D -m 0755 $(@D)/install/lib/libmpi.so.40.20.0 $(P64H_DEB_DIR)/usr/lib/libmpi.so.40.20.0
	$(INSTALL) -D -m 0755 $(@D)/install/lib/libopen-rte.so.40.20.0 $(P64H_DEB_DIR)/usr/lib/libopen-rte.so.40.20.0
	$(INSTALL) -D -m 0755 $(@D)/install/lib/libopen-pal.so.40.20.0 $(P64H_DEB_DIR)/usr/lib/libopen-pal.so.40.20.0

	# copy the mpi binaries, except (all variants of) the mpiCC compiler
	$(INSTALL) -D -m 0755 $(@D)/install/bin/mpi[!Ccf]* \
						  $(@D)/install/bin/or* \
						  $(@D)/install/bin/ompi?[!w]* \
						  $(P64H_DEB_DIR)/usr/bin/
	$(call P64H_DEBIAN_PACKAGE_BUILD)
endef
