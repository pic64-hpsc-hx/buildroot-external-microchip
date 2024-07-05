LINUX_OVERRIDE_SRCDIR = $(P64H_LINUX_DIR)

# Common exclusion rules when syncing p64h-linux-examples sources locally.
P64H_RSYNC_EXCLUDE_LIST = \
	--exclude /build/ \
	--exclude Jenkinsfile \
	--exclude .gitignore \
	--exclude .gitatrributes \
	--exclude readme.md \
	--exclude /platforms/ \
	--exclude /venv/ \
	--include /install/libs/*** \
	--exclude /install/* \

P64H_EXAMPLES_OVERRIDE_SRCDIR_RSYNC_EXCLUSIONS = $(P64H_RSYNC_EXCLUDE_LIST)
P64H_BENCHMARKS_OVERRIDE_SRCDIR_RSYNC_EXCLUSIONS = $(P64H_RSYNC_EXCLUDE_LIST)
P64H_LIBS_OVERRIDE_SRCDIR_RSYNC_EXCLUSIONS = $(P64H_RSYNC_EXCLUDE_LIST)
P64H_LKMS_OVERRIDE_SRCDIR_RSYNC_EXCLUSIONS = $(P64H_RSYNC_EXCLUDE_LIST)

# Check if P64H_TOPDIR environment variable is set
ifeq (,$(strip $(P64H_TOPDIR)))
$(error P64H_TOPDIR environment variable is not set. Set P64H_TOPDIR to point to your local p64h-linux-examples repository.)
endif