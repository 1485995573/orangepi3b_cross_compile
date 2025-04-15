# 顶层CMake文件

cmake_minimum_required(VERSION 3.10)

# 设置策略CMP0074为NEW，让CMake使用<PackageName>_ROOT变量
if(POLICY CMP0074)
  cmake_policy(SET CMP0074 NEW)
endif()

project(OrangePi3B_Project VERSION 1.0.0 LANGUAGES CXX)

# 设置C++标准
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_BUILD_TYPE Debug)
# 设置构建类型
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release)
endif()
message(STATUS "Build type: ${CMAKE_BUILD_TYPE}")

# 设置安装目录
if(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
    set(CMAKE_INSTALL_PREFIX "${CMAKE_BINARY_DIR}/install" CACHE PATH "Installation directory" FORCE)
endif()

# 检测是否在交叉编译模式
if(CMAKE_CROSSCOMPILING)
    message(STATUS "交叉编译模式 - 目标架构: ${CMAKE_SYSTEM_PROCESSOR}")
    # 处理OpenCV库路径
    set(OpenCV_ROOT "${CMAKE_SOURCE_DIR}/3rdparty/opencv-4.5.4")
    message(STATUS "OpenCV目录: ${OpenCV_ROOT}")
    set(OPENCV_CONFIG_PATHS
        "${OpenCV_ROOT}/lib/cmake/opencv4"
        "${OpenCV_ROOT}/share/opencv4"
        "${OpenCV_ROOT}/lib/cmake"
        "${OpenCV_ROOT}"
    )
    set(OpenCV_DIR "")
    foreach(path ${OPENCV_CONFIG_PATHS})
        if(EXISTS "${path}/OpenCVConfig.cmake")
            set(OpenCV_DIR "${path}")
            message(STATUS "找到OpenCV配置文件: ${OpenCV_DIR}/OpenCVConfig.cmake")
            break()
        endif()
    endforeach()
    find_package(OpenCV REQUIRED)

    # 添加include目录
    include_directories(${OpenCV_INCLUDE_DIRS})
else()
    message(STATUS "本地编译模式")
    find_package(OpenCV REQUIRED)
    include_directories(${OpenCV_INCLUDE_DIRS})
endif()
# 添加测试程序
add_subdirectory(src/opencv_test)
