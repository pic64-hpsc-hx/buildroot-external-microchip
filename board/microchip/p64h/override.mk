LINUX_OVERRIDE_SRCDIR = $(P64H_TOPDIR)/install/appc/linux_kernel
P64H_EXAMPLES_OVERRIDE_SRCDIR = $(P64H_TOPDIR)
P64H_BENCHMARKS_OVERRIDE_SRCDIR = $(P64H_TOPDIR)
P64H_LIBS_OVERRIDE_SRCDIR = $(P64H_TOPDIR)/install/libs
P64H_LKMS_OVERRIDE_SRCDIR = $(P64H_TOPDIR)/drivers

P64H_BENCHMARKS_OVERRIDE_SRCDIR_RSYNC_EXCLUSIONS = -L --exclude=/examples/benchmarks/TFLite \
																											--include=/{,'examples/'{,'benchmarks/'{,'**'}}} \
																											--include=/{,'install/'{,'libs/'{,'**'}}} \
																											--exclude "*"
P64H_EXAMPLES_OVERRIDE_SRCDIR_RSYNC_EXCLUSIONS =   -L --exclude=/examples/benchmarks \
																											--include=/{,'examples/'{,'**'}} \
																											--include=/{,'tools/'{,'etc/'{,'cmake/'{,'**'}}}} \
																											--include=/{,'install/'{,'share/'{,'libs/'{,'**'}}}} \
																											--include=/{,'install/'{,'share/'{,'drivers/'{,'**'}}}} \
																											--include=/{,'drivers/'{,'p64h_uio/'{,'**'}}} \
																											--exclude "*"
