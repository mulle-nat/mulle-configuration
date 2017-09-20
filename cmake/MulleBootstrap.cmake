option( MULLE_BOOTSTRAP "Find DEPENDENCIES_DIR and ADDICTIONS_DIR" ON)

if( MULLE_BOOTSTRAP)
  #
  # if using mulle_bootstrap, DEPENDENCIES_DIR is defined and
  # mulle-boostrap will set up the paths, so don't mess with it
  #
   if( NOT DEPENDENCIES_DIR)
     execute_process( COMMAND mulle-bootstrap paths -m dependencies
                      WORKING_DIRECTORY "${PROJECT_SOURCE_DIR}"
                      OUTPUT_VARIABLE DEPENDENCIES_DIR
                      OUTPUT_STRIP_TRAILING_WHITESPACE)
     message( STATUS "DEPENDENCIES_DIR is ${DEPENDENCIES_DIR} according to mulle-bootstrap")
     if( NOT DEPENDENCIES_DIR)
        set( DEPENDENCIES_DIR "dependencies")
        set( CMAKE_FIND_ROOT_PATH ${DEPENDENCIES_DIR})
     endif()
   endif()

   if( NOT ADDICTIONS_DIR)
     execute_process( COMMAND mulle-bootstrap paths -m addictions
                      WORKING_DIRECTORY "${PROJECT_SOURCE_DIR}"
                      OUTPUT_VARIABLE ADDICTIONS_DIR
                      OUTPUT_STRIP_TRAILING_WHITESPACE)
     message( STATUS "ADDICTIONS_DIR is ${ADDICTIONS_DIR} according to mulle-bootstrap")
     if( NOT ADDICTIONS_DIR)
        set( CMAKE_FIND_ROOT_PATH
             ${CMAKE_FIND_ROOT_PATH}
             ${ADDICTIONS_DIR}
        )
        set( ADDICTIONS_DIR "addictions")
     endif()
   endif()
endif()
