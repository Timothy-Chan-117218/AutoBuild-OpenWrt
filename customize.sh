#!/bin/bash
#=================================================
# Description: DIY script
# Lisence: MIT
# Author: Timothy-Chan-117218
#=================================================
#1. Modify default IP
sed -i 's/192.168.1.1/192.168.8.1/g' openwrt/package/base-files/files/bin/config_generate

# 替换默认Argon主题（最新版本适配有问题,先取消）
# rm -rf package/lean/luci-theme-argon
# git clone https://github.com/jerrykuku/luci-theme-argon package/luci-theme-argon

# 添加第三方软件包
git clone https://github.com/destan19/OpenAppFilter package/OpenAppFilter
git clone https://github.com/vernesong/OpenClash package/openclash
git clone https://github.com/tty228/luci-app-serverchan package/luci-app-serverchan
git clone https://github.com/rufengsuixing/luci-app-adguardhome package/luci-app-adguardhome
git clone https://github.com/kang-mk/luci-app-smartinfo package/luci-app-smartinfo

# 自定义定制选项
sed -i 's#192.168.1.1#192.168.8.1#g' package/base-files/files/bin/config_generate #定制默认IP
sed -i 's@.*CYXluq4wUazHjmCDBCqXF*@#&@g' package/lean/default-settings/files/zzz-default-settings #取消系统默认密码
sed -i 's@.*stats auth admin:root*@#&@g' package/lean/luci-app-haproxy-tcp/root/etc/haproxy_init.sh #取消haproxy默认密码
sed -i 's#frontend ss-in#frontend HAProxy-in#g' package/lean/luci-app-haproxy-tcp/root/etc/haproxy_init.sh #修改haproxy默认节点名称
sed -i 's#backend ss-out#backend HAProxy-out#g' package/lean/luci-app-haproxy-tcp/root/etc/haproxy_init.sh #修改haproxy默认节点名称
sed -i 's#option commit_interval 24h#option commit_interval 10m#g' feeds/packages/net/nlbwmon/files/nlbwmon.config #修改流量统计写入为10分钟
sed -i 's#option database_directory /var/lib/nlbwmon#option database_directory /etc/config/nlbwmon_data#g' feeds/packages/net/nlbwmon/files/nlbwmon.config #修改流量统计数据存放默认位置

#创建自定义配置文件 - OpenWrt-x86-64

rm -f ./.config*
touch ./.config

