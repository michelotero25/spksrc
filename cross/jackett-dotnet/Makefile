PKG_NAME = Jackett-dotnet
PKG_VERS = 0.16.1583
PKG_EXT = tar.gz
PKG_DIST_NAME = v$(PKG_VERS).$(PKG_EXT)
PKG_DIST_FILE = $(PKG_NAME)-$(PKG_VERS).$(PKG_EXT)
PKG_DIST_SITE = https://github.com/Jackett/Jackett/archive
PKG_DIR = Jackett-$(PKG_VERS)/src

DEPENDS = native/dotnet-sdk

HOMEPAGE = https://github.com/Jackett/Jackett
COMMENT  = Jackett works as a proxy server: it translates queries from apps into tracker-site-specific http queries, parses the html response, then sends results back to the requesting software. Jackett is a single repository of maintained indexer scraping & translation logic - removing the burden from other apps.
LICENSE  = GNU GPL v2

DOTNET_SMALL = 1
DOTNET_SELF_CONTAINED = 1
DOTNET_PACKAGE_NAME = Jackett.Server

SET_VERSION = /p:AssemblyVersion=$(PKG_VERS) /p:FileVersion=$(PKG_VERS) /p:InformationalVersion=$(PKG_VERS) /p:Version=$(PKG_VERS)
DOTNET_BUILD_PROPERTIES += $(SET_VERSION)

include ../../mk/spksrc.cross-dotnet.mk
