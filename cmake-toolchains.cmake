##
## require PROJECT_DIR && PLATFORM_DIR
##

if(ANDROID)
    set(PLATFORM_DIR ${PROJECT_DIR}/platforms/Android)
elseif(IOS)
    set(PLATFORM_DIR ${PROJECT_DIR}/platforms/iOS)
elseif(OSX)
    set(PLATFORM_DIR ${PROJECT_DIR}/platforms/OSX)
elseif(WIN32)
    set(PLATFORM_DIR ${PROJECT_DIR}/platforms/Windows)
endif()

include(${CMAKE_CURRENT_LIST_DIR}/cmake-android/func_android.cmake)     # Android
include(${CMAKE_CURRENT_LIST_DIR}/cmake-apple/func_apple.cmake)         # apple
include(${CMAKE_CURRENT_LIST_DIR}/cmake-emcc/emscripten-options.cmake)  # emcc
include(${CMAKE_CURRENT_LIST_DIR}/cmake-go/func_go.cmake)               # go
include(${CMAKE_CURRENT_LIST_DIR}/cmake-qt/func_qt.cmake)               # Qt
include(${CMAKE_CURRENT_LIST_DIR}/cmake-win/func_win.cmake)             # windows
include(${CMAKE_CURRENT_LIST_DIR}/cmake-core/func_core.cmake)           # Core
## find-deps
## link-options