#include <opencv2/opencv.hpp>
#include <iostream>
#include <string>

int main(int argc, char** argv)
{
    // 打印OpenCV版本
    std::cout << "OpenCV版本: " << CV_VERSION << std::endl;
    
    // 检查命令行参数
    if (argc != 2) {
        std::cout << "用法: " << argv[0] << " <图像路径>" << std::endl;
        return -1;
    }
    
    // 读取图像
    std::string imagePath = argv[1];
    cv::Mat image = cv::imread(imagePath);
    
    // 检查图像是否成功加载
    if (image.empty()) {
        std::cerr << "错误: 无法加载图像 " << imagePath << std::endl;
        return -1;
    }
    
    // 显示原始图像信息
    std::cout << "图像信息:" << std::endl;
    std::cout << " - 尺寸: " << image.cols << "x" << image.rows << std::endl;
    std::cout << " - 通道数: " << image.channels() << std::endl;
    std::cout << " - 类型: " << image.type() << std::endl;
    
    // 转换为灰度图
    cv::Mat grayImage;
    cv::cvtColor(image, grayImage, cv::COLOR_BGR2GRAY);
    
    // 应用高斯模糊
    cv::Mat blurredImage;
    cv::GaussianBlur(grayImage, blurredImage, cv::Size(5, 5), 0);
    
    // 应用Canny边缘检测
    cv::Mat edgesImage;
    cv::Canny(blurredImage, edgesImage, 50, 150);
    
    // 保存处理后的图像
    std::string outputPath = "edges_" + imagePath.substr(imagePath.find_last_of("/\\") + 1);
    cv::imwrite(outputPath, edgesImage);
    std::cout << "已保存处理后的图像至: " << outputPath << std::endl;
    
    // 如果是桌面环境，显示图像
    #ifndef __aarch64__
    cv::imshow("原始图像", image);
    cv::imshow("边缘检测", edgesImage);
    cv::waitKey(0);
    #endif
    
    return 0;
}
