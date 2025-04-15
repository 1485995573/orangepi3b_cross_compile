# 1.网络配置
## 1.1.临时配置
```bash
sudo ip addr add 192.168.1.9/24 dev eth0
sudo ip route add default via 192.168.1.1
```
## 1.2.永久配置
```bash
sudo vim /etc/netplan/orangepi-default.yaml
```

```bash
network:
  version: 2
  renderer: NetworkManager
  ethernets:
    eth0:
      dhcp4: no
      addresses:
        - 192.168.1.9/24
      gateway4: 192.168.1.1
      nameservers:
        addresses:
          - 114.114.114.114
          - 8.8.4.4
  wifis:
    wlan0:
      dhcp4: yes  # 使用 DHCP 自动获取 IP
      access-points:
        "666":  # SSID
          hidden: true
          password: "tulongbaodao1"  # Wi-Fi 密码
```

```bash
sudo netplan apply
sudo reboot
```

# 2.账号配置
```bash
su root
passwd root
passwd orangepi
```

# 3.库安装
```bash
sudo apt update
# 安装C++运行库
sudo apt install build-essential gcc g++ libc6-dev
# 安装OpenCV共享库(4.5.4)
sudo apt install libopencv-dev
# 安装Qt共享库(5.15.3)
sudo apt install libqt5core5a libqt5gui5 libqt5widgets5
# 验证安装
# 检查已安装的OpenCV库
opencv_version
# 检查已安装的Qt库
dpkg -l | grep libqt5core
```

# 4.动态链接器安装
```bash
# 由于apt install libc不包含动态链接器，手动下载libc deb包
wget http://ports.ubuntu.com/pool/main/g/glibc/libc6_2.35-0ubuntu3.9_arm64.deb
# 解包
dpkg-deb -x libc6_2.35-0ubuntu3.9_arm64.deb libc6_contents
# 把包里面的动态连接器拷贝到相应位置
sudo cp libc6_contents/lib/aarch64-linux-gnu/ld-linux-aarch64.so.1 /lib/aarch64-linux-gnu/
# 查看编译输出文件依赖、动态连接器
ldd ./opencv_test
readelf -l ./opencv_test | grep interpreter
# 把下载的动态链接器软链接成依赖一样的名字
sudo ln -sf /lib/aarch64-linux-gnu/ld-linux-aarch64.so.1 /lib/aarch64-linux-gnu/ld-2.35.so
```