#
# Copyright (c) 2015 Presisco
# Author: presisco <internight@sina.com>
#

include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-tinydrcom
PKG_VERSION:=1.0
PKG_RELEASE:=1

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/luci-app-tinydrcom
  SECTION:=luci
  CATEGORY:=LuCI
  SUBMENU:=3. Applications
  TITLE:=LuCI Configure interface for TinyDrcom
  MAINTAINER:=presisco <internight@sina.com>
  DEPENDS:=+tinydrcom +luci
endef

define Package/luci-app-tinydrcom/conffiles
/etc/config/tinydrcom
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
endef

define Build/Compile/Default

endef
Build/Compile = $(Build/Compile/Default)

define Package/luci-app-tinydrcom/install
	$(RM) $(1)/etc/init.d/tinydrcom
	$(RM) $(1)/etc/config/tinydrcom.conf
	$(CP) -a root/* $(1)
	
	chmod 755 $(1)/usr/bin/tinydrcom-daemon.sh
	chmod 755 $(1)/etc/init.d/tinydrcom-conf
endef

$(eval $(call BuildPackage,luci-app-tinydrcom))
