if(ANDROID)
    ## ANDROID_TOOLCHAIN
    if(${ANDROID_ABI} STREQUAL "arm64-v8a")
        set(ANDROID_TOOLCHAIN_INC ${ANDROID_SYSROOT}/usr/include/aarch64-linux-android)
    else() # armeabi-v7a && etc.
        set(ANDROID_TOOLCHAIN_INC ${ANDROID_SYSROOT}/usr/include/arm-linux-androideabi)
    endif()
endif()
