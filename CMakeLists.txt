cmake_minimum_required(VERSION 2.8)
project(demo)


# ------------------------------------------------------------------------------
# Initial settings for our project
# ------------------------------------------------------------------------------

# Check mandatory env variables
if (NOT DEFINED ENV{Qt5_host})
  message(FATAL_ERROR "Configure the env variable Qt5_host to point to your host Qt5 installation.")
else()
  message(STATUS "Qt5 host installation dir: $ENV{Qt5_host}")
endif()

if (NOT DEFINED ENV{Qt5_android})
  message(FATAL_ERROR "Configure the env variable Qt5_android to point to your android Qt5 installation.")
else()
  message(STATUS "Qt5 android installation dir: $ENV{Qt5_android}")
endif()

# Minimum Qt version
set(QT_REQUIRED_VERSION 5.3.0)

# Set application version
set(DEMO_MAJOR_VERSION 0)
set(DEMO_MINOR_VERSION 1)
set(DEMO_PATCH_VERSION 0)
set(DEMO_VERSION ${DEMO_MAJOR_VERSION}.${DEMO_MINOR_VERSION})

# An integer value that represents the version of the application
# Increase it at each release
set(DEMO_VERSION_CODE ${DEMO_MINOR_VERSION})

# Cmake modules setup
set(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake/")

# Tell Cmake to run moc when necessary
set(CMAKE_AUTOMOC ON)

# Since moc files are generated in the build dir, tell cmake to always look for
# includes there
set(CMAKE_INCLUDE_CURRENT_DIR ON)

# Set c++11 support
include(CheckCXXCompilerFlag)
CHECK_CXX_COMPILER_FLAG("-std=c++11" COMPILER_SUPPORTS_CXX11)
CHECK_CXX_COMPILER_FLAG("-std=c++0x" COMPILER_SUPPORTS_CXX0X)
if (COMPILER_SUPPORTS_CXX11)
  set(my_cxx_flags "-std=c++11")
elseif (COMPILER_SUPPORTS_CXX0X)
  set(my_cxx_flags "-std=c++0x")
else()
  message(STATUS "The compiler ${CMAKE_CXX_COMPILER} has no C++11 support. Please use a different C++ compiler.")
endif()
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${my_cxx_flags}")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${my_cxx_flags}")

# Each Qt5 package finds its own dependencies
find_package(Qt5 ${QT_REQUIRED_VERSION} CONFIG REQUIRED Qml Quick Gui)

# OS Configurations
if (ANDROID)
  set(CMAKE_PREFIX_PATH "$ENV{Qt5_android}/lib/cmake/Qt5")
  set(_dest_dir android/assets)

  # Android .so output
  set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/android/libs/${ARM_TARGET}/)
else()
    set(CMAKE_PREFIX_PATH "$ENV{Qt5_host}/lib/cmake/Qt5")
  set(_dest_dir bin)

  # Desktop build
  set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
endif()

# Set the directory where tools will get installed
set(DEMO_TOOLS_BINARY_DIR ${CMAKE_BINARY_DIR}/tools)

# Add other subdirectories containing CMakeLists.txt file
add_subdirectory(src)
add_subdirectory(tools)
if (ANDROID)
  add_subdirectory(android)
endif()
