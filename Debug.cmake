# just for C-projects

include( Common)


#
# if using mulle_bootstrap, DEPENDENCIES_DIR  is defined and
# mulle-boostrap will set up the paths, so don't mess with it
#
# These setting are for ppl. who build the project as a top
# level project
#
if( NOT DEPENDENCIES_DIR )
   set( DEPENDENCY_FRAMEWORK_DIRS
   dependencies/Framework/Debug
   ${DEPENDENCY_LIBRARY_DIRS}
   )

   set( DEPENDENCY_LIBRARY_DIRS
   dependencies/lib/Debug
   ${DEPENDENCY_LIBRARY_DIRS}
   )

   link_directories(${CMAKE_BINARY_DIR}
   ${DEPENDENCY_LIBRARY_DIRS}
   )
endif()

set( OTHER_C_FLAGS "-O0 -g -DDEBUG ${UNWANTED_WARNINGS}")

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${OTHER_C_FLAGS}")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${OTHER_C_FLAGS}")

