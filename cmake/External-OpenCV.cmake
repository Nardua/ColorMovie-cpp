message("External project: OpenCV")
include(${CMAKE_ROOT}/Modules/ExternalProject.cmake)
ExternalProject_Add(opencv
  GIT_REPOSITORY ${git_protocol}://github.com/opencv/opencv
  GIT_TAG 3.4.3
  SOURCE_DIR opencv
  UPDATE_COMMAND ""
  PATCH_COMMAND ""
  CMAKE_GENERATOR ${gen}
  CMAKE_ARGS
    ${ep_common_args}
    -DBUILD_DOCS:BOOL=OFF
    -DBUILD_EXAMPLES:BOOL=OFF
    -DBUILD_NEW_PYTHON_SUPPORT:BOOL=OFF
    -DBUILD_WITH_DEBUG_INFO=OFF
    -DBUILD_PACKAGE:BOOL=OFF
    -DBUILD_opencv_core=ON
    -DBUILD_opencv_imgproc=ON
    -DBUILD_opencv_highgui=ON
    -DBUILD_opencv_video=ON
    -DBUILD_opencv_apps=OFF
    -DBUILD_opencv_flann=ON
    -DBUILD_opencv_gpu=OFF
    -DBUILD_opencv_ml=ON
    -DBUILD_opencv_legacy=OFF
    -DBUILD_opencv_calib3d=OFF
    -DBUILD_opencv_features2d=ON
    -DBUILD_opencv_java=OFF
    -DBUILD_opencv_objdetect=OFF
    -DBUILD_opencv_photo=OFF
    -DBUILD_opencv_nonfree=OFF
    -DBUILD_opencv_ocl=OFF
    -DBUILD_opencv_stitching=OFF
    -DBUILD_opencv_superres=OFF
    -DBUILD_opencv_ts=OFF
    -DBUILD_opencv_videostab=OFF
    -DBUILD_SHARED_LIBS:BOOL=ON
    -DBUILD_TESTS:BOOL=OFF
    -DBUILD_PERF_TESTS:BOOL=OFF
    -DBUILD_opencv_contrib=ON
    -DBUILD_WITH_CAROTENE=OFF
    -DCMAKE_BUILD_TYPE:STRING=Release
    -DWITH_FFMPEG:BOOL=ON
    -DWITH_IPP:BOOL=OFF
    -DWITH_GTK:BOOL=ON
    -DBUILD_PNG:BOOL=OFF
    -DBUILD_JPEG:BOOL=ON
    -DBUILD_ZLIB:BOOL=ON
    -DBUILD_WITH_STATIC_CRT:BOOL=ON
    -DBUILD_FAT_JAVA_LIB=OFF
    -DCMAKE_INSTALL_PREFIX:PATH=${CMAKE_SOURCE_DIR}/install/thirdparty/opencv/
)
set(OPENCV_INSTALL_DIR ${CMAKE_SOURCE_DIR}/install/thirdparty/opencv)

set(OPENCV_INCLUDE_DIR ${OPENCV_INSTALL_DIR}/include)
if(NOT WIN32)
  set(OPENCV_LIBRARY_DIR ${OPENCV_INSTALL_DIR}/lib)
else()
  set(OPENCV_LIBRARY_DIR ${OPENCV_INSTALL_DIR}/x86/vc12/lib)
endif()

set(OPENCV_LIBRARIES opencv_imgproc opencv_core opencv_highgui opencv_video opencv_videoio opencv_imgcodecs opencv_features2d)

include_directories(${OPENCV_INCLUDE_DIR})
link_directories(${OPENCV_LIBRARY_DIR})

if(EXISTS "${CMAKE_BINARY_DIR}/thirdparty/share/OpenCV/OpenCVConfig.cmake")
    include(${CMAKE_BINARY_DIR}/thirdparty/share/OpenCV/OpenCVConfig.cmake)
    add_custom_target(myopencv)
else()
    add_custom_target(myopencv ${CMAKE_COMMAND} ${CMAKE_SOURCE_DIR} DEPENDS opencv)
endif()