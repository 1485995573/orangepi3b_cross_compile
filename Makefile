.PHONY: build cross_build rebuild cross_rebuild run burn clean clean_cross
build: 
	@mkdir -p build_x64
	@cd build_x64 && cmake .. && cmake --build . -- -j$(nproc)

# 交叉编译
cross_build:
	@mkdir -p build_aarch64
	@cd build_aarch64 && cmake -DCMAKE_TOOLCHAIN_FILE=../aarch64-toolchain.cmake .. && cmake --build . -- -j$(nproc)

rebuild: clean build

cross_rebuild: clean cross_build

clean:
	@rm -rf ./build/* ./build_aarch64/*

run: build
	@echo "运行本地编译版本..."

burn:
	@scp -r /home/cwb/code/orangepi3b/project/build_aarch64/src/opencv_test/opencv_test orangepi@192.168.1.9:/home/orangepi/ir_project

install_lib:
	@rsync -av --links /home/cwb/code/orangepi3b/project/3rdparty/opencv-4.5.4/lib/* orangepi@192.168.1.9:/home/orangepi/ir_project/lib/