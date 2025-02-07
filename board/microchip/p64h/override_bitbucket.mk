BR2_LINUX_KERNEL_CUSTOM_TARBALL=n
BR2_LINUX_KERNEL_VERSION="linux4microchip+p64h-2024.07"

BR2_LINUX_KERNEL_CUSTOM_GIT=y
BR2_LINUX_KERNEL_CUSTOM_REPO_URL="https://bitbucket.microchip.com/scm/hpsc/linux.git"
BR2_LINUX_KERNEL_CUSTOM_REPO_VERSION="linux4microchip+p64h-2024.07"

P64H_EXAMPLES_OVERRIDE_SRCDIR = $(P64H_TOPDIR)
P64H_BENCHMARKS_OVERRIDE_SRCDIR = $(P64H_TOPDIR)
P64H_LIBS_OVERRIDE_SRCDIR = $(P64H_TOPDIR)/install/libs
P64H_LKMS_OVERRIDE_SRCDIR = $(P64H_TOPDIR)/drivers

# Common exclusion rules when syncing p64h-linux-examples sources locally.
P64H_RSYNC_EXCLUDE_LIST = \
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

P64H_EXAMPLES_OVERRIDE_SRCDIR_RSYNC_EXCLUSIONS = $(P64H_RSYNC_EXCLUDE_LIST) --exclude /examples/benchmarks
P64H_BENCHMARKS_OVERRIDE_SRCDIR_RSYNC_EXCLUSIONS = $(P64H_RSYNC_EXCLUDE_LIST) --exclude /examples/benchmarks/TFLite
