include(ExternalProject)
add_custom_target(thirdparty)

# eigen
ExternalProject_Add(
    eigen3.3.4
    URL http://gitlab.baidu.com/zhaochenxu02/maplab_dependencies_downloads/raw/master/eigen-3.3.4.zip
    PREFIX ${PROJECT_SOURCE_DIR}/thirdparty/eigen3.3.4
    CMAKE_ARGS -DCMAKE_INSTALL_PREFIX:PATH=${PROJECT_SOURCE_DIR}/thirdparty/eigen3.3.4/build -DBUILD_SHARED_LIBS=ON
)
add_dependencies(thirdparty eigen3.3.4)

# gtest
ExternalProject_Add(
    google_gtest
    URL http://gitlab.baidu.com/qinziwen/vpas_ibl_dependencies_downloads/raw/master/googletest-release-1.8.0.zip
    URL_MD5 adfafc8512ab65fd3cf7955ef0100ff5
    PREFIX ${PROJECT_SOURCE_DIR}/thirdparty/gtest
    BUILD_IN_SOURCE true
    CONFIGURE_COMMAND cd ${PROJECT_SOURCE_DIR}/thirdparty/gtest/src/google_gtest && cmake .
        -DCMAKE_INSTALL_PREFIX=${PROJECT_SOURCE_DIR}/thirdparty/gtest/build
        -DBUILD_SHARED_LIBS=ON
    BUILD_COMMAND cd ${PROJECT_SOURCE_DIR}/thirdparty/gtest/src/google_gtest && make -j8
    INSTALL_COMMAND cd ${PROJECT_SOURCE_DIR}/thirdparty/gtest/src/google_gtest && make install -j8
)
add_dependencies(thirdparty google_gtest)

# gflags
ExternalProject_Add(
    google_gflags
    URL http://gitlab.baidu.com/qinziwen/vpas_ibl_dependencies_downloads/raw/master/gflags-2.2.2.zip
    URL_MD5 ff856ff64757f1381f7da260f79ba79b
    PREFIX ${PROJECT_SOURCE_DIR}/thirdparty/gflags
    BUILD_IN_SOURCE true
    CONFIGURE_COMMAND cd ${PROJECT_SOURCE_DIR}/thirdparty/gflags/src/google_gflags && cmake .
        -DCMAKE_INSTALL_PREFIX=${PROJECT_SOURCE_DIR}/thirdparty/gflags/build
        -DBUILD_SHARED_LIBS=ON
    BUILD_COMMAND cd ${PROJECT_SOURCE_DIR}/thirdparty/gflags/src/google_gflags && make -j8
    INSTALL_COMMAND cd ${PROJECT_SOURCE_DIR}/thirdparty/gflags/src/google_gflags && make install -j8
)
add_dependencies(thirdparty google_gflags)

# glog
ExternalProject_Add(
    google_glog
    DEPENDS google_gflags
    URL http://gitlab.baidu.com/qinziwen/vpas_ibl_dependencies_downloads/raw/master/glog-0.4.0.zip
    URL_MD5 2899b069b8229d49cd65eda5271315ad
    PREFIX ${PROJECT_SOURCE_DIR}/thirdparty/glog
    BUILD_IN_SOURCE true
    CONFIGURE_COMMAND cd ${PROJECT_SOURCE_DIR}/thirdparty/glog/src/google_glog && cmake .
        -DCMAKE_INSTALL_PREFIX=${PROJECT_SOURCE_DIR}/thirdparty/glog/build
        -DBUILD_SHARED_LIBS=ON
        -DCMAKE_INSTALL_LIBDIR=lib
        -DWITH_GFLAGS=OFF
    BUILD_COMMAND cd ${PROJECT_SOURCE_DIR}/thirdparty/glog/src/google_glog && make -j8
    INSTALL_COMMAND cd ${PROJECT_SOURCE_DIR}/thirdparty/glog/src/google_glog && make install -j8
)
add_dependencies(thirdparty google_glog)

# yaml_cpp
ExternalProject_Add(
    yaml_cpp
    URL http://gitlab.baidu.com/qinziwen/vpas_ibl_dependencies_downloads/raw/master/yaml-cpp-yaml-cpp-0.6.3.zip
    URL_MD5 e8a182537af663cc45228f7064b2021c
    PREFIX ${PROJECT_SOURCE_DIR}/thirdparty/yaml_cpp
    BUILD_IN_SOURCE true
    CONFIGURE_COMMAND cd ${PROJECT_SOURCE_DIR}/thirdparty/yaml_cpp/src/yaml_cpp && cmake .
        -DCMAKE_INSTALL_PREFIX=${PROJECT_SOURCE_DIR}/thirdparty/yaml_cpp/build
        -DYAML_BUILD_SHARED_LIBS=ON
    BUILD_COMMAND cd ${PROJECT_SOURCE_DIR}/thirdparty/yaml_cpp/src/yaml_cpp && make -j8
    INSTALL_COMMAND cd ${PROJECT_SOURCE_DIR}/thirdparty/yaml_cpp/src/yaml_cpp && make install -j8
)
add_dependencies(thirdparty yaml_cpp)

# paddle
if(BUILD_paddle)
    ExternalProject_Add(
        baidu_paddle
        URL http://gitlab.baidu.com/lizhaohu01/paddle2.0/raw/master/Paddle-2.0.0.zip
        URL_MD5 4afccacd21a6615a3cb681ba5e6f87b7
        PREFIX ${PROJECT_SOURCE_DIR}/thirdparty/paddle
        BUILD_IN_SOURCE true
        CONFIGURE_COMMAND cd ${PROJECT_SOURCE_DIR}/thirdparty/paddle/src/baidu_paddle && cmake .
            -DFLUID_INFERENCE_INSTALL_DIR=${PROJECT_SOURCE_DIR}/thirdparty/paddle/build
            -DCMAKE_BUILD_TYPE=Release
            -DWITH_PYTHON=OFF
            -DWITH_MKL=OFF
            -DWITH_MKLDNN=OFF
            -DWITH_GPU=ON
            -DON_INFER=ON
            -DWITH_NCCL=OFF
        BUILD_COMMAND cd ${PROJECT_SOURCE_DIR}/thirdparty/paddle/src/baidu_paddle && ulimit -n 2048 && make -j8 
        INSTALL_COMMAND cd ${PROJECT_SOURCE_DIR}/thirdparty/paddle/src/baidu_paddle && make inference_lib_dist -j8
    )
    add_dependencies(thirdparty baidu_paddle)
endif(BUILD_paddle)

# protobuf
ExternalProject_Add(
    google_protobuf
    URL http://gitlab.baidu.com/qinziwen/vpas_ibl_dependencies_downloads/raw/master/protobuf-3.12.3.zip
    URL_MD5 e202b61dd8f22fe9f68ceb099876640f
    PREFIX ${PROJECT_SOURCE_DIR}/thirdparty/protobuf
    BUILD_IN_SOURCE true
    CONFIGURE_COMMAND ""
    BUILD_COMMAND sh autogen.sh && ./configure --prefix=${PROJECT_SOURCE_DIR}/thirdparty/protobuf/build --disable-STATIC && make -j8
    INSTALL_COMMAND make install -j8
)
add_dependencies(thirdparty google_protobuf)

ExternalProject_Add(
    opencv4_contrib
    URL http://gitlab.baidu.com/zhaochenxu02/opencv4.5.2_src_code/raw/master/opencv_contrib4.5.2.zip
    URL_MD5 929322fee4c2209819d6ef9f271861e5
    PREFIX ${PROJECT_SOURCE_DIR}/thirdparty/opencv4_contrib
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ""
    INSTALL_COMMAND ""
)

# opencv
ExternalProject_Add(
    opencv4.5.2
    DEPENDS opencv4_contrib
    URL http://gitlab.baidu.com/zhaochenxu02/opencv4.5.2_src_code/raw/master/opencv4.5.2.zip
    URL_MD5 1146895f9cdd7a53400366f6d935a81f
    PREFIX ${PROJECT_SOURCE_DIR}/thirdparty/opencv4.5.2
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND cd ${PROJECT_SOURCE_DIR}/thirdparty/opencv4.5.2/src/opencv4.5.2-build && cmake ../opencv4.5.2
        -DOPENCV_EXTRA_MODULES_PATH=${PROJECT_SOURCE_DIR}/thirdparty/opencv4_contrib/src/opencv4_contrib/modules
        -DBUILD_opencv_world=ON
        -DOPENCV_ENABLE_NON_FREE=ON
        -DWITH_CUDA=${Opencv_WITH_CUDA}
        -DCUDA_GENERATION=Auto
        -DBUILD_TESTS=OFF
        -DBUILD_PERF_TESTS=OFF
        -DBUILD_opencv_apps=OFF
        -DBUILD_EXAMPLES=OFF
        -DWITH_TBB=ON
        -DBUILD_opencv_python2=OFF
        -DBUILD_opencv_python3=OFF
        -DWITH_GTK_2_X=ON  # Can't use GTK3 as it links against system protobuf.
        -DWITH_GTK=OFF
        -DWITH_PNG=OFF
        -DBUILD_PNG=ON
        -DBUILD_PROTOBUF=OFF
        -DBUILD_TIFF=ON
        -DWITH_V4L=OFF
        -DBUILD_V4L=ON
        -DINSTALL_C_EXAMPLES=OFF
        -DINSTALL_PYTHON_EXAMPLES=OFF
        -DWITH_QT=OFF # Needed by clang under Ubuntu 14.04 and GTK_WIDGET(cvGetWindowHandle(...)) with gcc (image_view)
        -DWITH_OPENGL=ON
        -DWITH_VTK=ON
        -DWITH_PROTOBUF=OFF
        -DENABLE_PRECOMPILED_HEADERS=OFF
        -DENABLE_CXX11=ON
        -DCMAKE_INSTALL_PREFIX=${PROJECT_SOURCE_DIR}/thirdparty/opencv4.5.2/build
        -DBUILD_SHARED_LIBS=ON
        -DWITH_OPENCL=OFF
        -DBUILD_opencv_ts=OFF
        # opencv_contrib packages
        -DBUILD_opencv_dnn=ON # Pulls in the system protobuf as a dependency!
        -DBUILD_opencv_dnns_easily_fooled=ON
        -DBUILD_opencv_cnn_3dobj=OFF
        -DBUILD_opencv_aruco=OFF
        -DBUILD_opencv_bgsegm=OFF
        -DBUILD_opencv_bioinspired=OFF
        -DBUILD_opencv_ccalib=OFF
        -DBUILD_opencv_contrib_world=ON
        -DBUILD_opencv_datasets=ON
        -DBUILD_opencv_dpm=OFF
        -DBUILD_opencv_face=ON
        -DBUILD_opencv_fuzzy=OFF
        -DBUILD_opencv_freetype=OFF
        -DBUILD_opencv_hdf=OFF
        -DBUILD_opencv_line_descriptor=ON
        -DBUILD_opencv_matlab=OFF
        -DBUILD_opencv_optflow=OFF
        -DBUILD_opencv_plot=ON
        -DBUILD_opencv_reg=OFF
        -DBUILD_opencv_rgbd=ON
        -DBUILD_opencv_saliency=ON
        -DBUILD_opencv_sfm=OFF
        -DBUILD_opencv_stereo=OFF
        -DBUILD_opencv_structured_light=OFF
        -DBUILD_opencv_surface_matching=OFF
        -DBUILD_opencv_text=ON
        -DBUILD_opencv_tracking=ON
        -DBUILD_opencv_xfeatures2d=ON
        -DBUILD_opencv_ximgproc=OFF
        -DBUILD_opencv_xobjdetect=OFF
        -DBUILD_opencv_xphoto=OFF
        -DCMAKE_INSTALL_LIBDIR=lib
    BUILD_COMMAND cd ${PROJECT_SOURCE_DIR}/thirdparty/opencv4.5.2/src/opencv4.5.2-build && make -j8
    INSTALL_COMMAND cd ${PROJECT_SOURCE_DIR}/thirdparty/opencv4.5.2/src/opencv4.5.2-build && make install -j8
)
add_dependencies(thirdparty opencv4.5.2)

# opengv 
ExternalProject_Add(
    opengv
    DEPENDS eigen3.3.4
    GIT_REPOSITORY ssh://g@gitlab.baidu.com:8022/VPS-AR/opengv.git
    GIT_TAG feature/gpnp
    PREFIX ${PROJECT_SOURCE_DIR}/thirdparty/opengv
    CMAKE_ARGS -DEIGEN_INCLUDE_DIR=${PROJECT_SOURCE_DIR}/thirdparty/eigen3.3.4/src/eigen3.3.4 -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR> -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=ON
)
add_dependencies(thirdparty opengv)

# boost 1.58
ExternalProject_Add(
    boost_158
    URL http://gitlab.baidu.com/qinziwen/vpas_ibl_dependencies_downloads/raw/master/boost_1_58.zip
    URL_MD5 20cff08c62292a3b59072d2079b8c901
    PREFIX ${PROJECT_SOURCE_DIR}/thirdparty/boost_158
    BUILD_IN_SOURCE true
    CONFIGURE_COMMAND ./bootstrap.sh --with-libraries=program_options,serialization,system,filesystem,timer,thread --prefix=${PROJECT_SOURCE_DIR}/thirdparty/boost_158/build
    BUILD_COMMAND cd ${PROJECT_SOURCE_DIR}/thirdparty/boost_158/src/boost_158 && ./b2 install -j8
    INSTALL_COMMAND ""
)
add_dependencies(thirdparty boost_158)

# popsift
ExternalProject_Add(
    popsift
    DEPENDS opencv4.5.2 google_glog
    URL http://gitlab.baidu.com/zhaochenxu02/popsift_support_opencv4.5.2/raw/master/popsift.zip
    URL_MD5 7f2d507f076e9954756fd8f0659f55cc
    PREFIX ${PROJECT_SOURCE_DIR}/thirdparty/popsift
    BUILD_IN_SOURCE true
    CONFIGURE_COMMAND cd ${PROJECT_SOURCE_DIR}/thirdparty/popsift/src/popsift && cmake .
    BUILD_COMMAND make -j8 && cp libpopsift.so ../../ && cp ./include/popsift/detect_and_compute.h ../../
    INSTALL_COMMAND ""
)
add_dependencies(thirdparty popsift)
