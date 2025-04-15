# 1.交叉编译工具链安装
```bash
# 安装gcc-11交叉编译器
sudo apt install gcc-11-aarch64-linux-gnu g++-11-aarch64-linux-gnu
# 在本机运行下面这一行，检查Glibc.so的版本
strings /usr/aarch64-linux-gnu/lib/libc.so.6 | grep GLIBC_
# 在orangepi运行下面这一行，检查Glibc.so的版本
strings /lib/aarch64-linux-gnu/libc.so.6 | grep GLIBC_
# GNU C Library (Ubuntu GLIBC 2.35-0ubuntu3.9) stable release version 2.35.
```

# 2.交叉编译OpenCV-4.5.4
```bash
cmake -DCMAKE_TOOLCHAIN_FILE=../platforms/linux/aarch64-gnu.toolchain.cmake \
      -DGCC_COMPILER_VERSION="11" \
      -DCMAKE_C_COMPILER=aarch64-linux-gnu-gcc \
      -DCMAKE_CXX_COMPILER=aarch64-linux-gnu-g++ \
      -DCMAKE_C_FLAGS="-Wl,--dynamic-linker=/lib/aarch64-linux-gnu/ld-2.35.so -D__GLIBC_USE=0x2023" \
      -DCMAKE_CXX_FLAGS="-Wl,--dynamic-linker=/lib/aarch64-linux-gnu/ld-2.35.so -D__GLIBC_USE=0x2023" \
      -DCMAKE_INSTALL_PREFIX=/home/cwb/work/orangepi_3B/project/3rdparty/opencv-4.5.4 \
      -DCMAKE_BUILD_TYPE=Release \
      -DBUILD_EXAMPLES=OFF \
      -DBUILD_TESTS=OFF \
      -DBUILD_JPEG=ON \
      -DBUILD_PNG=ON \
      ..
```
```bash
make -j$(nproc)
```

# 3.交叉编译Qt-5.15.3
(libqt5core5a libqt5gui5 libqt5widgets5)