##
## require PROJECT_DIR && PLATFORM_DIR
##

if(ANDROID)
    set(PLATFORM_DIR ${PROJECT_DIR}/platforms/Android)
elseif(IOS)
    set(PLATFORM_DIR ${PROJECT_DIR}/platforms/iOS)
elseif(OSX)
    set(PLATFORM_DIR ${PROJECT_DIR}/platforms/OSX)
elseif(WIN)
    set(PLATFORM_DIR ${PROJECT_DIR}/platforms/Windows)
endif()

set(CMAKE_TOOLCHAIN_ROOT ${CMAKE_CURRENT_LIST_DIR})
include(${CMAKE_CURRENT_LIST_DIR}/cmake-android/android_func.cmake)     # Android
include(${CMAKE_CURRENT_LIST_DIR}/cmake-apple/apple_func.cmake)         # apple
include(${CMAKE_CURRENT_LIST_DIR}/cmake-emcc/emscripten-options.cmake)  # emcc
include(${CMAKE_CURRENT_LIST_DIR}/cmake-go/go_func.cmake)               # go
include(${CMAKE_CURRENT_LIST_DIR}/cmake-qt/qt_func.cmake)               # Qt
include(${CMAKE_CURRENT_LIST_DIR}/cmake-win/win_func.cmake)             # Windows
include(${CMAKE_CURRENT_LIST_DIR}/cmake-core/global.cmake)              # Core
## find-deps
## link-options