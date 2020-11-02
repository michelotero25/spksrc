PKG_NAME = nodejs
# Latest Current Version: 13.13.0 (includes npm 6.14.4)
PKG_VERS = 13.13.0
PKG_EXT = tar.xz
PKG_DIST_NAME = node-v$(PKG_VERS)-linux-x64.$(PKG_EXT)
PKG_DIST_SITE = https://nodejs.org/dist/v$(PKG_VERS)
PKG_DIR = node-v$(PKG_VERS)-linux-x64

DEPENDS =

HOMEPAGE = https://nodejs.org/
COMMENT  = JavaScript runtime built on Chrome's V8 JavaScript engine.
LICENSE  = https://github.com/nodejs/node/blob/master/LICENSE

CONFIGURE_TARGET = nop
COMPILE_TARGET = nop
INSTALL_TARGET = nodejs-install

include ../../mk/spksrc.native-cc.mk

.PHONY: nodejs-install
nodejs-install:
	install -m 755 -d $(STAGING_INSTALL_PREFIX)/bin
	install -m 755 -d $(STAGING_INSTALL_PREFIX)/lib
	install -m 755 -d $(STAGING_INSTALL_PREFIX)/include
	install -m 755 $(WORK_DIR)/$(PKG_DIR)/bin/* $(STAGING_INSTALL_PREFIX)/bin/
	cp -r $(WORK_DIR)/$(PKG_DIR)/lib/. $(STAGING_INSTALL_PREFIX)/lib/
	cp -r $(WORK_DIR)/$(PKG_DIR)/include/. $(STAGING_INSTALL_PREFIX)/include/
