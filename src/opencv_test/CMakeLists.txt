# OpenCV测试程序的CMake配置

# 添加可执行文件
add_executable(opencv_test main.cpp)

# 链接OpenCV库
target_link_libraries(opencv_test ${OpenCV_LIBS})