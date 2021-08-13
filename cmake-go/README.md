# cmake-go
https://blog.icorer.com/index.php/archives/382/

## CMakeDetermineGoCompiler.cmake
Go语言编译器的总入口, 负责的工作包括:

- 在操作系统环境中寻找Go语言编译器
- 加载Go编译器参数
- 拷贝必要的编译配置文件

## golang.cmake
在 CMakeDetermineGoCompiler.cmake 文件基础上实现了必要的 Go代码编译函数, 主要功能函数包括:

- go get 支持 : 为编译所需的外部包的引入提供自动加载功能
- 编译单体程序 : 编译指定路径下的go源代码, 生成单体程序体

## cpack.cmake
负责对编译后的工程进行打包工作, 打包的格式包括 RPM, ZIP 等

## flags.cmake
使用 cgo 时引用。