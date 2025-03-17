################################################################################
#
# p64h-examples: Helpers
#
################################################################################

# Default output directory for Debian package builds
P64H_DEBPKG_OUTPUT_DIR ?= $(BUILD_DIR)/p64h-debian_packages

# Setup Debian package build environment
define P64H_DEBIAN_PACKAGE_SETUP
	@echo "... Setup $(1) debian package build environment"; \
	$(eval P64H_DEB_DEFAULT_VERSION := 1.0.0) \
	$(eval P64H_DEB_VERSION := $(shell cat $(1)/DEBIAN/control | sed -n 's/^Version: //p' || echo "$(P64H_DEB_DEFAULT_VERSION)")) \
	$(eval P64H_DEB_PACKAGE_NAME := $(shell cat $(1)/DEBIAN/control | sed -n 's/^Package: //p')) \
	$(eval P64H_DEB_PACKAGE_ARCH := $(shell cat $(1)/DEBIAN/control | sed -n 's/^Architecture: //p')) \
	$(eval P64H_DEB_FILENAME := $(P64H_DEB_PACKAGE_NAME)_$(P64H_DEB_VERSION)_$(P64H_DEB_PACKAGE_ARCH).deb) \
	$(eval TEMP_DIR := $(HOME)/tmp/$(shell mktemp -d BR_DEBPKG_BUILD-XXXXXXXXXX -u)) \
	$(eval P64H_DEB_DIR := $(TEMP_DIR)/$(notdir $(1))) \
	if [ -z "$(P64H_DEB_VERSION)" -o -z "$(P64H_DEB_PACKAGE_NAME)" -o -z "$(P64H_DEB_PACKAGE_ARCH)" ]; then \
		echo "ERROR parsing $(1)/DEBIAN/control, one or more required variables are empty:"; \
		echo "       P64H_DEB_VERSION = $(P64H_DEB_VERSION)"; \
		echo "  P64H_DEB_PACKAGE_NAME = $(P64H_DEB_PACKAGE_NAME)"; \
		echo "  P64H_DEB_PACKAGE_ARCH = $(P64H_DEB_PACKAGE_ARCH)"; \
		rm -rf $(TEMP_DIR); \
		exit 1; \
	fi; \
	docker build -t hpsc_debian_pkgbuild:11-1 $(P64H_EXAMPLES_BUILD_DIR)/debian_packages/Dockerfiles; \
	mkdir -p -m 0755 $(P64H_DEBPKG_OUTPUT_DIR); \
	mkdir -p -m 0755 $(P64H_DEB_DIR); \
	cp -r $(1)/* $(P64H_DEB_DIR);
endef

# Build Debian package
define P64H_DEBIAN_PACKAGE_BUILD
	echo "... Building $(P64H_DEB_FILENAME)"; \
	docker run -u $(shell id -u):$(shell id -g) --rm -v $(P64H_DEB_DIR)/../:/apt-package hpsc_debian_pkgbuild:11-1 dpkg-deb --build $(P64H_DEB_PACKAGE_NAME) $(P64H_DEB_FILENAME); \
	if [ ! -f $(P64H_DEB_DIR)/../$(P64H_DEB_FILENAME) ]; then \
		echo "ERROR: $(P64H_DEB_FILENAME) package was not created successfully">&2; \
		exit 1; \
	else \
		echo "... Debian package was created successfully">&2; \
		cp -rf $(P64H_DEB_DIR)/../* $(P64H_DEBPKG_OUTPUT_DIR); \
	fi; \
	rm -rf $(TEMP_DIR);
endef

# Copy debian_package build dependencies into package build directory
define P64H_DEBIAN_PACKAGE_DEPS
	rm -rf $(1)/debian_packages
	mkdir -p $(1)/debian_packages
	cp -r $(BUILD_DIR)/p64h-$(P64H_VERSION)/debian_packages/* $(1)/debian_packages
endef