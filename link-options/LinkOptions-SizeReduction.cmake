include(${CMAKE_CURRENT_LIST_DIR}/LinkOptions.cmake)

# clang LTO is broken with __thread variables #498 
# https://github.com/android-ndk/ndk/issues/498
# Workaround is -Wl,-plugin-opt=-emulated-tls
# set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -fPIC -flto -O3 -Wl,-plugin-opt=-emulated-tls -Wl,--gc-sections -Wl,--exclude-libs,ALL -Wl,--as-needed" CACHE INTERNAL "" FORCE)
set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -fPIC -flto -O3 -Wl,--gc-sections -Wl,--exclude-libs,ALL -Wl,--as-needed" CACHE INTERNAL "" FORCE)

# Currently aarch64 not using gold linker as default (it has error for Cortex-A53), so don't enable icf for it
if((CMAKE_SYSTEM_PROCESSOR STREQUAL "armv7-a") OR (CMAKE_SYSTEM_PROCESSOR STREQUAL "x86") OR (CMAKE_SYSTEM_PROCESSOR STREQUAL "x86_64"))
  set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -Wl,--icf=safe" CACHE INTERNAL "" FORCE)
endif()

