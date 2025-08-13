################################################################################
#
# p64h for PIC64-HPSC-HX SoC.
#
################################################################################

P64H_LICENSE = MIT
P64H_LICENSE_FILES = LICENSE
export P64H_PLATFORM = $(call qstrip,$(BR2_PACKAGE_P64H_PLATFORM))

ifeq ($(BR2_PACKAGE_P64H_LATEST_VERSION),y)
P64H_SITE = https://kulwant78774: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@github.com/pic64-hpsc-hx/p64h-linux-examples.git
P64H_VERSION = p64h-v1.7.0_dev
P64H_SITE_METHOD = git
else ifeq ($(BR2_PACKAGE_P64H_BITBUCKET),y)
P64H_SITE = $(call qstrip,$(BR2_PACKAGE_P64H_BITBUCKET_SOURCE))
P64H_VERSION = $(call qstrip,$(BR2_PACKAGE_P64H_BITBUCKET_VERSION))
P64H_SITE_METHOD = git
else ifeq ($(BR2_PACKAGE_P64H_LOCALDIR),y)
P64H_SITE = $(call qstrip,$(BR2_PACKAGE_P64H_LOCALDIR_LOCATION))
P64H_VERSION = custom
P64H_SITE_METHOD = local
else ifeq ($(BR2_PACKAGE_P64H_CUSTOM_VERSION),y)
P64H_SITE = git@github.com:pic64-hpsc-hx/p64h-linux-examples.git
P64H_VERSION = $(call qstrip,$(BR2_PACKAGE_P64H_CUSTOM_VERSION_VALUE))
P64H_SITE_METHOD = git
endif

define P64H_BUILD_CMDS
    $(@D)/tools/bin/build.sh -W --without-debian
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