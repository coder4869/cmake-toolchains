## link-flags
if (EMSCRIPTEN)
    # SET(CMAKE_FIND_LIBRARY_SUFFIXES ".a")
    # SET(BUILD_SHARED_LIBRARIES OFF)

    message("++++++++++++ emcc ++++++++++++")
    set(CMAKE_AR "emcc")
    set(CMAKE_C_CREATE_STATIC_LIBRARY "<CMAKE_AR> -o <TARGET> <LINK_FLAGS> <OBJECTS>")
    set(CMAKE_CXX_CREATE_STATIC_LIBRARY "<CMAKE_AR> -o <TARGET> <LINK_FLAGS> <OBJECTS>")

    set(CMAKE_EXECUTABLE_SUFFIX ".js")
    set(CMAKE_STATIC_LIBRARY_SUFFIX ".a") 
    # set(CMAKE_STATIC_LIBRARY_SUFFIX ".bc") # bitcode
    # emcc hello.c -s WASM=1 --no-entry -s EXPORTED_RUNTIME_METHODS="['ccall','cwrap']"
    set(link_options "-sWASM=1 --no-entry -o ${WASM_OUTPUT_NAME}.js")
    set(link_options "${link_options} -sEXPORTED_RUNTIME_METHODS=\"['ccall','cwrap']\" ")

    set(link_options "${link_options} -sEXPORTED_FUNCTIONS=\"['_malloc','_free']\" ")
    # set(link_options "${link_options} -sEXPORTED_FUNCTIONS=@${WASM_EXPORT_API_FILE} ")

    # set(link_options "${link_options} -sLLD_REPORT_UNDEFINED ")
    
    # set(link_options "${link_options} -sWASM_ASYNC_COMPILATION=0")  ## ASYNC
    # set(link_options "${link_options} -sERROR_ON_UNDEFINED_SYMBOLS=0")  ## Error
    
    set(link_options "${link_options} -sUSE_WEBGL2=2 -sFULL_ES2=1 -sFULL_ES3=1 -sUSE_SDL=2 ")  ## GL
    set(link_options "${link_options} --bind")  ## Embind - EMSCRIPTEN_BINDINGS

    set(CMAKE_STATIC_LINKER_FLAGS "${CMAKE_STATIC_LINKER_FLAGS} ${link_options}")
    set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} ${link_options}")
endif()