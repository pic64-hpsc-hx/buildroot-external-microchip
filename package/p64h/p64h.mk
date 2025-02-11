################################################################################
#
# p64h for PIC64-HPSC-HX SoC.
#
################################################################################

P64H_SITE = ssh://git@bitbucket.microchip.com/hpsc/p64h-linux-examples.git
P64H_SITE_METHOD = git
P64H_VERSION = main
P64H_LICENSE = MIT
P64H_LICENSE_FILES = LICENSE

define P64H_BUILD_CMDS
    $(@D)/tools/bin/build.sh -W 
endef

# Files to exclude from rsync when sourcing from localdir
P64H_OVERRIDE_SRCDIR_RSYNC_EXCLUSIONS = \
	--exclude /build/ \
	--exclude /venv/ \
	--include /install/libs \
	--include /install/libs/eigen \
	--include /install/libs/openblas \
	--include /install/libs/openmpi \
	--include /install/share \
	--exclude /install/share/drivers \
	--exclude /install/share/third_party \
	--exclude /install/share/tools \
	--exclude /install/* \

$(eval $(generic-package))