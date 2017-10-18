#
# Common stuff for Debug and Release
# C and ObjC
#
set( MULLE_CONFIGURATION_VERSION 3)

cmake_policy( SET CMP0054 NEW)

# makes nicer Xcode projects, I see no detriment
set_property( GLOBAL PROPERTY USE_FOLDERS ON)

if( APPLE)
   cmake_minimum_required (VERSION 3.0)

   # CMAKE_OSX_SYSROOT must be set for CMAKE_OSX_DEPLOYMENT_TARGET (cmake bug)
   if( NOT CMAKE_OSX_SYSROOT)
      set( CMAKE_OSX_SYSROOT "/" CACHE STRING "SDK for OSX" FORCE)   # means current OS X
   endif()

   # baseline set to OSX_VERSION for rpath (is this still needed?)
   if( NOT CMAKE_OSX_DEPLOYMENT_TARGET)
      execute_process( COMMAND sw_vers -productVersion
                       OUTPUT_VARIABLE OSX_VERSION_FULL
                       OUTPUT_STRIP_TRAILING_WHITESPACE)
      string(REGEX REPLACE "\\.[^.]*$" "" OSX_VERSION ${OSX_VERSION_FULL})

      set(CMAKE_OSX_DEPLOYMENT_TARGET "${OSX_VERSION}" CACHE STRING "Deployment target for OSX" FORCE)
   endif()

   set( CMAKE_POSITION_INDEPENDENT_CODE FALSE)

   # linker stuff
   # prefix ObjC libraries with force_load ( OS X)
   set( BEGIN_ALL_LOAD)
   set( END_ALL_LOAD)
   set( FORCE_LOAD_PREFIX "-force_load ")
else()
   if( WIN32)
      # may not be enough though...

      cmake_minimum_required (VERSION 3.4)

      # set only for libraries ?
      set( CMAKE_POSITION_INDEPENDENT_CODE TRUE)

      # linker stuff (since VS 2015)
      set( FORCE_LOAD_PREFIX "-WHOLEARCHIVE:")
   else()
      # UNIXy gcc based
      cmake_minimum_required (VERSION 3.0)

      # set only for libraries ?
      set( CMAKE_POSITION_INDEPENDENT_CODE TRUE)

      # linker stuff
      # prefix libraries with force_load ( OS X)
      set( BEGIN_ALL_LOAD "-Wl,--whole-archive")
      set( END_ALL_LOAD "-Wl,--no-whole-archive")
      set( FORCE_LOAD_PREFIX)
   endif()
endif()


if( NOT MULLE_C_COMPILER_ID)
   if( ("${CMAKE_SYSTEM_NAME}" STREQUAL "Windows") AND ( "${CMAKE_C_COMPILER_ID}" MATCHES "^(Clang|MulleClang)$") )
      set( MULLE_C_COMPILER_ID "MSVC-${CMAKE_C_COMPILER_ID}")
   else()
      set( MULLE_C_COMPILER_ID "${CMAKE_C_COMPILER_ID}")
   endif()
endif()

if( NOT MULLE_CXX_COMPILER_ID)
   if( ("${CMAKE_SYSTEM_NAME}" STREQUAL "Windows") AND ( "${CMAKE_CXX_COMPILER_ID}" MATCHES "^(Clang|MulleClang)$") )
      set( MULLE_CXX_COMPILER_ID "MSVC-${CMAKE_CXX_COMPILER_ID}")
   else()
      set( MULLE_CXX_COMPILER_ID "${CMAKE_CXX_COMPILER_ID}")
   endif()
endif()

if( "${MULLE_C_COMPILER_ID}" MATCHES "^(Clang|AppleClang|MulleClang|GNU)$")
   set( UNWANTED_C_WARNINGS "-Wno-parentheses -Wno-int-to-void-pointer-cast")
else()
   if( "${MULLE_C_COMPILER_ID}" MATCHES "^(Intel|MSVC|MSVC-Clang|MSVC-MulleClang)$")
      # C4068: unwanted pragma
      set( UNWANTED_C_WARNINGS "/D_CRT_SECURE_NO_WARNINGS /wd4068 /wd4113")
   endif()
endif()

if( "${MULLE_C_COMPILER_ID}" MATCHES "^(MSVC-Clang|MSVC-MulleClang)$")
   # set( CMAKE_C_FLAGS "${CMAKE_C_FLAGS}")
   # 4211 is for classes..
   set( CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} /ignore:4221")
   set( CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} /ignore:4221")
   set( CMAKE_STATIC_LINKER_FLAGS "${CMAKE_STATIC_LINKER_FLAGS} /ignore:4221")
endif()

include( MulleBootstrap)

# include( MulleTests) # too early
