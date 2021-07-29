# eg. XCODE_SETTING(<SDK> 9.0/10.13)

function(XCODE_SETTING target_name min_version)
    if(IOS OR OSX)
        # Deployment Postprocess
        XCODE_DEPLOYMENT_POSTPROCESSING(${target_name})
        # Generate Debug Symbols 
        XCODE_DEBUG_SYMBOLS(${target_name})
        # XCode Debug Information Format
        XCODE_DEBUG_INFO_FMT(${target_name})
        # XCode Strip Linked Product
        XCODE_STRIP_INSTALLED_PRODUCT(${target_name})
    
        set_target_properties( ${target_name} PROPERTIES
            XCODE_ATTRIBUTE_CLANG_ENABLE_OBJC_ARC YES
            XCODE_ATTRIBUTE_CLANG_CXX_LANGUAGE_STANDARD "c++14"
            XCODE_ATTRIBUTE_GCC_OPTIMIZATION_LEVEL[variant=Release] s
            XCODE_ATTRIBUTE_LLVM_LTO[variant=Release] YES                   
            XCODE_ATTRIBUTE_GCC_INPUT_FILETYPE sourcecode.cpp.objcpp    # objc++
            XCODE_ATTRIBUTE_OTHER_CFLAGS[variant=Release] "-fembed-bitcode"
            XCODE_ATTRIBUTE_BITCODE_GENERATION_MODE "bitcode"
            )  
    endif()
    
    # For IOS
    if(IOS)
        set_target_properties( ${target_name} PROPERTIES
            XCODE_ATTRIBUTE_IPHONEOS_DEPLOYMENT_TARGET ${min_version}
            XCODE_ATTRIBUTE_ARCHS "arm64"
            XCODE_ATTRIBUTE_SDKROOT iphoneos
            )
        # append flags for XCODE_ATTRIBUTE_GCC_PREPROCESSOR_DEFINITIONS
        add_definitions(-D __IOS__=1)
        # target_compile_definitions(${target_name} PRIVATE __IOS__ )

        configure_file(${CMAKE_CURRENT_LIST_DIR}/res/IOSBundleInfo.plist.in ${CMAKE_BINARY_DIR}/Info.plist)
        set_target_properties(${PROJECT_NAME} PROPERTIES MACOSX_BUNDLE_INFO_PLIST ${CMAKE_BINARY_DIR}/Info.plist)
    elseif(OSX)
        set_target_properties( ${target_name} PROPERTIES
            XCODE_ATTRIBUTE_MACOSX_DEPLOYMENT_TARGET ${min_version}
            XCODE_ATTRIBUTE_ARCHS "x86_64"
            XCODE_ATTRIBUTE_OTHER_CODE_SIGN_FLAGS "--deep" # for Error "codesign": code object is not signed at all
            XCODE_ATTRIBUTE_SDKROOT macosx
            )
        # append flags for XCODE_ATTRIBUTE_GCC_PREPROCESSOR_DEFINITIONS
        add_definitions(-D __OSX__=1)
        # target_compile_definitions(${target_name} PRIVATE __OSX__ )

        configure_file(${CMAKE_CURRENT_LIST_DIR}/res/MacOSXBundleInfo.plist.in ${CMAKE_BINARY_DIR}/Info.plist)
        set_target_properties(${PROJECT_NAME} PROPERTIES MACOSX_BUNDLE_INFO_PLIST ${CMAKE_BINARY_DIR}/Info.plist)
    endif()

endfunction(XCODE_SETTING)


######################################## IOS && OSX universal ########################################

# XCode Deployment Postprocessing : Default value is YES after XCode 9.1, always used for app slim down.
# NO  : keep non-essential compile symbol. e.g. debug symbol. 
# YES : delete non-essential compile symbol and protect app. e.g. debug symbol.
function(XCODE_DEPLOYMENT_POSTPROCESSING target_name)
    if(IOS OR OSX)
        set_target_properties( ${target_name} PROPERTIES
            XCODE_ATTRIBUTE_DEPLOYMENT_POSTPROCESSING[variant=Debug] "NO"
            XCODE_ATTRIBUTE_DEPLOYMENT_POSTPROCESSING[variant=MinSizeRel] "YES"
            XCODE_ATTRIBUTE_DEPLOYMENT_POSTPROCESSING[variant=RelWithDebInfo] "NO"
            XCODE_ATTRIBUTE_DEPLOYMENT_POSTPROCESSING[variant=Release] "YES"
            )  
    endif()
endfunction(XCODE_DEPLOYMENT_POSTPROCESSING)

# XCode Generate Debug Symbols : always used for app slim down.
function(XCODE_DEBUG_SYMBOLS target_name)
    if(IOS OR OSX)
        set_target_properties( ${target_name} PROPERTIES
            XCODE_ATTRIBUTE_GCC_GENERATE_DEBUGGING_SYMBOLS[variant=Debug] "YES"
            XCODE_ATTRIBUTE_GCC_GENERATE_DEBUGGING_SYMBOLS[variant=MinSizeRel] "NO"
            XCODE_ATTRIBUTE_GCC_GENERATE_DEBUGGING_SYMBOLS[variant=RelWithDebInfo] "YES"
            XCODE_ATTRIBUTE_GCC_GENERATE_DEBUGGING_SYMBOLS[variant=Release] "NO"
            )  
    endif()
endfunction(XCODE_DEBUG_SYMBOLS)

# XCode Debug Information Format
function(XCODE_DEBUG_INFO_FMT target_name)
    if(IOS OR OSX)
        set_target_properties( ${target_name} PROPERTIES
            XCODE_ATTRIBUTE_DEBUG_INFORMATION_FORMAT[variant=Debug] "dwarf-with-dsym"
            XCODE_ATTRIBUTE_DEBUG_INFORMATION_FORMAT[variant=MinSizeRel] "dwarf"
            XCODE_ATTRIBUTE_DEBUG_INFORMATION_FORMAT[variant=RelWithDebInfo] "dwarf-with-dsym"
            XCODE_ATTRIBUTE_DEBUG_INFORMATION_FORMAT[variant=Release] "dwarf"
            )  
    endif()
endfunction(XCODE_DEBUG_INFO_FMT)

# XCode Strip Linked Product
function(XCODE_STRIP_INSTALLED_PRODUCT target_name)
    if(IOS OR OSX)
        set_target_properties( ${target_name} PROPERTIES
            XCODE_ATTRIBUTE_STRIP_INSTALLED_PRODUCT[variant=Debug] "NO"
            XCODE_ATTRIBUTE_STRIP_INSTALLED_PRODUCT[variant=MinSizeRel] "YES"
            XCODE_ATTRIBUTE_STRIP_INSTALLED_PRODUCT[variant=RelWithDebInfo] "NO"
            XCODE_ATTRIBUTE_STRIP_INSTALLED_PRODUCT[variant=Release] "YES"
            )  
    endif()
endfunction(XCODE_STRIP_INSTALLED_PRODUCT)

# Strip Debug Symbols During Copy
# function(XCODE_DEBUG_SYMBOLS_DURING_COPY target_name)
#     if(IOS OR OSX)
#         set_target_properties( ${target_name} PROPERTIES
#             XCODE_ATTRIBUTE_DEBUG_INFORMATION_FORMAT[variant=Debug] "NO"
#             XCODE_ATTRIBUTE_DEBUG_INFORMATION_FORMAT[variant=MinSizeRel] "YES"
#             XCODE_ATTRIBUTE_DEBUG_INFORMATION_FORMAT[variant=RelWithDebInfo] "NO"
#             XCODE_ATTRIBUTE_DEBUG_INFORMATION_FORMAT[variant=Release] "YES"
#             )  
#     endif()
# endfunction(XCODE_DEBUG_SYMBOLS_DURING_COPY)


######################################## XCode Add Files ########################################

function(XCODE_ADD_META RES_FILES)
    if (APPLE)
        set(ICON_NAME AppIcon)
        set(ICON_FILE ${CMAKE_CURRENT_LIST_DIR}/res/${ICON_NAME}.icns)
        set_source_files_properties(${ICON_FILE} PROPERTIES MACOSX_PACKAGE_LOCATION Resources)

        # Identify MacOS bundle
        set(MACOSX_BUNDLE_BUNDLE_NAME ${PROJECT_NAME})
        set(MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION})
        set(MACOSX_BUNDLE_LONG_VERSION_STRING ${PROJECT_VERSION})
        set(MACOSX_BUNDLE_SHORT_VERSION_STRING "${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}")
        set(MACOSX_BUNDLE_COPYRIGHT ${COPYRIGHT})
        set(MACOSX_BUNDLE_GUI_IDENTIFIER ${IDENTIFIER})
        set(MACOSX_BUNDLE_ICON_FILE ${ICON_NAME})
        
        set(${RES_FILES} ${ICON_FILE})
    endif()
endfunction(XCODE_ADD_META)