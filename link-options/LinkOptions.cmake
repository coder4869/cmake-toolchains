if(CMAKE_SYSTEM_PROCESSOR STREQUAL "armv7-a")
#  message("!!! Linker Options for ${CMAKE_SYSTEM_PROCESSOR} !!!")
  set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -Wl,--fix-cortex-a8" CACHE INTERNAL "" FORCE)
endif()

# TODO: We need this for now cuz we're getting some odd linker errors in OpenSceneGraph of this sort:
# /Users/Dario/Dev/ThirdPartyLibs/OpenSceneGraph/OpenSceneGraph-3.5.2-1dc1fef-Android-patch/armeabi-v7a/libosgAnimation.a(MorphGeometry.cpp.o):MorphGeometry.cpp:function osgAnimation::AnimationUpdateCallback<osg::NodeCallback>::~AnimationUpdateCallback(): warning: relocation refers to discarded section
# /Users/Dario/Dev/ThirdPartyLibs/OpenSceneGraph/OpenSceneGraph-3.5.2-1dc1fef-Android-patch/armeabi-v7a/libosgAnimation.a(MorphGeometry.cpp.o):MorphGeometry.cpp:function osgAnimation::AnimationUpdateCallback<osg::NodeCallback>::AnimationUpdateCallback(std::string const&): warning: relocation refers to discarded section
# Get rid of this when we figure it out
set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -Wl,--no-fatal-warnings" CACHE INTERNAL "" FORCE)
