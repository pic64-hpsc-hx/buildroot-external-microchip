################################################################################
#
# p64h-rpmid: RPMI daemon (sysc_rpmid) for PIC64-HPSC-HX SoC AppC Linux.
#
# Packaged separately from p64h-examples so it can be installed without the
# examples set. Source download is shared with p64h via the P64H_VERSION
# build dir; build invocation mirrors p64h-examples (cmake/ninja, idempotent
# if the same target was already built by p64h-examples).
#
################################################################################

P64H_RPMID_BUILD_DIR    = $(BUILD_DIR)/p64h-$(P64H_VERSION)
P64H_RPMID_DEPENDENCIES = p64h

# Target directory for the installation
P64H_RPMID_TARGET_DIR = /opt/microchip

define P64H_RPMID_BUILD_CMDS
	$(P64H_RPMID_BUILD_DIR)/tools/bin/build.sh --build-examples --skip-buildroot -br p64h
endef

define P64H_RPMID_INSTALL_TARGET_CMDS
	rm -rf $(TARGET_DIR)$(P64H_RPMID_TARGET_DIR)/sysc_rpmid
	$(INSTALL) -D -m 0755 \
	    $(P64H_RPMID_BUILD_DIR)/build/examples/rpmi/sysc_rpmid/sysc_rpmid \
	    $(TARGET_DIR)$(P64H_RPMID_TARGET_DIR)/sysc_rpmid
endef

# Debian package build hook (consistent with p64h-examples pattern)
ifeq ($(P64H_DEBPKG_BUILD),1)
P64H_RPMID_POST_INSTALL_TARGET_HOOKS += P64H_RPMID_DEBIAN_PACKAGE_BUILD_RPMID
endif

define P64H_RPMID_DEBIAN_PACKAGE_BUILD_RPMID
	$(call P64H_DEBIAN_PACKAGE_SETUP,$(P64H_DEBPKG_SRC_DIR)/hpsc-rpmid) \
	mkdir -p -m 0775 $(P64H_DEB_DIR)/$(P64H_RPMID_TARGET_DIR); \
	$(INSTALL) -D -m 0755 \
	    $(P64H_RPMID_BUILD_DIR)/build/examples/rpmi/sysc_rpmid/sysc_rpmid \
	    $(P64H_DEB_DIR)/$(P64H_RPMID_TARGET_DIR); \
	$(call P64H_DEBIAN_PACKAGE_BUILD)
endef

$(eval $(generic-package))
