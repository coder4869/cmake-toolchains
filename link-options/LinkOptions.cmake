# message("!!! Linker Options for ${CMAKE_SYSTEM_PROCESSOR} !!!")
if(CMAKE_SYSTEM_PROCESSOR STREQUAL "armv7-a")
    set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -Wl,--fix-cortex-a8" CACHE INTERNAL "" FORCE)
endif()


#### Linker Optimization 
# https://blog.csdn.net/weixin_33724570/article/details/89731190
# https://blog.csdn.net/weixin_39716160/article/details/116607853

# --fatal-warnings will take all warnings as error, same to -Werror. Here cancel the limit!
set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -Wl,--no-fatal-warnings" CACHE INTERNAL "" FORCE)

# [clang LTO is broken with __thread variables #498](https://github.com/android-ndk/ndk/issues/498)
# Workaround is -Wl,-plugin-opt=-emulated-tls
set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -Wl,-plugin-opt=-emulated-tls" CACHE INTERNAL "" FORCE)
set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -fPIC -flto -O3 -Wl,--gc-sections -Wl,--exclude-libs,ALL -Wl,--as-needed" CACHE INTERNAL "" FORCE)

# gold linker has error for Cortex-A53 on aarch64, Remove icf(reduce lib size) for it.
if((CMAKE_SYSTEM_PROCESSOR STREQUAL "armv7-a") OR (CMAKE_SYSTEM_PROCESSOR STREQUAL "x86") OR (CMAKE_SYSTEM_PROCESSOR STREQUAL "x86_64"))
  set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -Wl,--icf=safe" CACHE INTERNAL "" FORCE)
endif()
