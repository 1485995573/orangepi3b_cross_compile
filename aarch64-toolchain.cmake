# 交叉编译工具链配置文件 - 使用系统安装的工具链

# 指定CMake系统名称
set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR aarch64)

# 使用APT安装的交叉编译工具
set(CMAKE_C_COMPILER aarch64-linux-gnu-gcc-11)
set(CMAKE_CXX_COMPILER aarch64-linux-gnu-g++-11)

# 添加OpenCV库路径到查找路径
set(CMAKE_FIND_ROOT_PATH "${CMAKE_CURRENT_LIST_DIR}/3rdparty/opencv-4.5.4")

# 设置查找规则
# 必须设置为NEVER，允许在宿主机上查找构建工具
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# 以下保持ONLY，确保使用目标平台的库
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

# 设置不允许测试编译器
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

# 限制GLIBC版本为2.35（目标板的版本）
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wl,--dynamic-linker=/lib/aarch64-linux-gnu/ld-2.35.so -D__GLIBC_USE=0x2023")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wl,--dynamic-linker=/lib/aarch64-linux-gnu/ld-2.35.so -D__GLIBC_USE=0x2023")

# 打印交叉编译配置信息
message(STATUS "  C compiler: ${CMAKE_C_COMPILER}")
message(STATUS "  CXX compiler: ${CMAKE_CXX_COMPILER}")
message(STATUS "  CMAKE_FIND_ROOT_PATH: ${CMAKE_FIND_ROOT_PATH}")
message(STATUS "  限制GLIBC版本为2.35以兼容目标板")
