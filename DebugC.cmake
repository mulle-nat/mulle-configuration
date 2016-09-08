#
# if using mulle_bootstrap, DEPENDENCIES_DIR  is defined and
# mulle-boostrap will set up the paths, so don't mess with it
#
# These setting are for ppl. who build the project as a top
# level project
#
if( NOT DEPENDENCIES_DIR )
   set( DEPENDENCY_LIBRARY_DIRS
      ${COMMON_DEPENDENCIES_DIR}/Debug/lib
      ${DEPENDENCY_LIBRARY_DIRS}
   )

   link_directories(${CMAKE_BINARY_DIR}
      ${DEPENDENCY_LIBRARY_DIRS}
   )
endif()

set( CMAKE_LIBRARY_PATH "${CMAKE_LIBRARY_PATH}
${COMMON_DEPENDENCIES_DIR}/Debug
${COMMON_DEPENDENCIES_DIR}"
)


if( MULLE_C_COMPILER_ID MATCHES "^(Intel|MSVC|MSVC-Clang|MSVC-MulleClang)$")
   set( OTHER_C_FLAGS "${OTHER_C_FLAGS} /Od /Z7 /DDEBUG=1 ")
else()
   set( OTHER_C_FLAGS "${OTHER_C_FLAGS} -O0 -g -DDEBUG")
endif()