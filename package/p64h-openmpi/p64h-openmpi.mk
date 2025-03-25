################################################################################
#
# p64h-openmpi: OpenMPI Library for PIC64-HPSC-HX SoC.
#
################################################################################

P64H_OPENMPI_VERSION = p64h-v1.7.0_dev
P64H_OPENMPI_SITE = git@github.com:pic64-hpsc-hx/p64h-openmpi.git
P64H_OPENMPI_SITE_METHOD = git
P64H_OPENMPI_LICENSE = MIT
P64H_OPENMPI_LICENSE_FILES = LICENSE
P64H_OPENMPI_GIT_SUBMODULES = YES

export OPENMPI_BUILD_DIR=$(BUILD_DIR)/p64h-openmpi-$(P64H_OPENMPI_VERSION)/install

define P64H_OPENMPI_BUILD_CMDS
	$(@D)/tools/bin/build.sh -j10
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