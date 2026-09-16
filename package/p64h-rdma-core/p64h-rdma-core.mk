################################################################################
#
# p64h-rdma-core
#
# Copied from buildroot/package/rdma-core/rdma-core.mk
#
################################################################################

P64H_RDMA_CORE_VERSION = b564723b27a51dc2d223a228398009be4b640604
P64H_RDMA_CORE_SITE = ssh://git@github.com/pic64-hpsc-hx/rdma-core.git
P64H_RDMA_CORE_SITE_METHOD = git
P64H_RDMA_CORE_LICENSE = GPL-2.0 or BSD-2-Clause
P64H_RDMA_CORE_LICENSE_FILES = COPYING.GPL2 COPYING.BSD_MIT COPYING.md
P64H_RDMA_CORE_DEPENDENCIES = libnl
P64H_RDMA_CORE_INSTALL_STAGING = YES

P64H_RDMA_CORE_CONF_OPTS = \
	-DNO_MAN_PAGES=1 \
	-DNO_PYVERBS=1

ifeq ($(BR2_TOOLCHAIN_HAS_LIBATOMIC),y)
P64H_RDMA_CORE_CONF_OPTS += \
	-DCMAKE_EXE_LINKER_FLAGS=-latomic \
	-DCMAKE_SHARED_LINKER_FLAGS=-latomic
endif

$(eval $(cmake-package))
