PKG_NAME = dotnet-sdk
# PKG_VERS = SDK 3.1.403 (v3.1.9 release)
# https://github.com/dotnet/core/blob/master/release-notes/3.1/3.1.9/3.1.9.md
PKG_VERS = 3.1.403
PKG_EXT = tar.gz
PKG_DIST_SITE = https://dotnetcli.azureedge.net/dotnet/Sdk/${PKG_VERS}
PKG_DIST_NAME = $(PKG_NAME)-$(PKG_VERS)-linux-x64.$(PKG_EXT)

# https://docs.microsoft.com/en-us/dotnet/core/install/dependencies?pivots=os-linux&tabs=netcore31
DEPENDS =

HOMEPAGE = https://dotnet.microsoft.com/
COMMENT  = A developer platform for building apps.
LICENSE  = MIT

CONFIGURE_TARGET = nop
COMPILE_TARGET = nop
INSTALL_TARGET = dotnet-install

# DOTNET_ROOT=$(WORK_DIR)/dotnet/
DOTNET_PACKAGES=$(DISTRIB_DIR)/nuget/packages

include ../../mk/spksrc.native-cc.mk

.PHONY: dotnet-install
dotnet-install:
	mkdir -p $(DOTNET_PACKAGES)
# 	$(RUN) cp -r ./* $(DOTNET_ROOT)/
