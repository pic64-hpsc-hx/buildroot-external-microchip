################################################################################
#
# p64h-openblas: OpenBLAS Library for PIC64-HPSC-HX SoC.
#
################################################################################

P64H_OPENBLAS_VERSION = p64h-v1.7.0_dev
P64H_OPENBLAS_SITE = git@github.com:pic64-hpsc-hx/openblas.git
P64H_OPENBLAS_SITE_METHOD = git
P64H_OPENBLAS_LICENSE = MIT
P64H_OPENBLAS_LICENSE_FILES = LICENSE
P64H_OPENBLAS_GIT_SUBMODULES = YES

export OPENBLAS_BUILD_DIR=$(BUILD_DIR)/p64h-openblas-$(P64H_OPENBLAS_VERSION)/openblas/install

define P64H_OPENBLAS_BUILD_CMDS
	$(@D)/tools/bin/build.sh -j10
endef

define P64H_OPENBLAS_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/openblas/install/lib/libopenblas_x280p-r0.3.28.so $(TARGET_DIR)/usr/lib/libopenblas_x280p-r0.3.28.so;
	ln -fs libopenblas_x280p-r0.3.28.so $(TARGET_DIR)/usr/lib/libopenblas.so.0;
endef

ifeq ($(P64H_DEBPKG_BUILD),1)
$(eval P64H_OPENBLAS_POST_INSTALL_TARGET_HOOKS += P64H_DEBIAN_PACKAGE_BUILD_OPENBLAS);
P64H_OPENBLAS_DEPENDENCIES = p64h
endif

$(eval $(generic-package))