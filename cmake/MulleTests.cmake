
option( MULLE_TEST "Enable link info output for mulle-test" OFF)


#
# Since tests do not know how to link stuff, and we don't really want to
# write a CMakeLists.txt for each test
# Let's emit some specific information for tests
#
# We could also just grep CMakeCache.txt here, but how stable is its format ?
#
if( MULLE_TEST)
   add_custom_target( test_support ALL
                   DEPENDS ${PROJECT_BINARY_DIR}/os-specific-libs.txt
                           ${PROJECT_BINARY_DIR}/c-dependency-libs.txt
                           ${PROJECT_BINARY_DIR}/objc-dependency-libs.txt
   )

# add_dependencies( MulleObjC os_specific_libs)

   add_custom_command( OUTPUT ${PROJECT_BINARY_DIR}/os-specific-libs.txt

                       COMMAND echo "${OS_SPECIFIC_LIBRARIES}" > ${PROJECT_BINARY_DIR}/os-specific-libs.txt

                       WORKING_DIRECTORY "${PROJECT_SOURCE_DIR}"
                       COMMENT "Creating os-specific-libs.txt"
                       VERBATIM)


   add_custom_command( OUTPUT ${PROJECT_BINARY_DIR}/c-dependency-libs.txt

                       COMMAND echo "${C_DEPENDENCY_LIBRARIES}" > ${PROJECT_BINARY_DIR}/c-dependency-libs.txt

                       WORKING_DIRECTORY "${PROJECT_SOURCE_DIR}"
                       COMMENT "Creating c-dependency-libs.txt"
                       VERBATIM)

   add_custom_command( OUTPUT ${PROJECT_BINARY_DIR}/objc-dependency-libs.txt

                       COMMAND echo "${OBJC_DEPENDENCY_LIBRARIES}" > ${PROJECT_BINARY_DIR}/objc-dependency-libs.txt

                       WORKING_DIRECTORY "${PROJECT_SOURCE_DIR}"
                       COMMENT "Creating objc-dependency-libs.txt"
                       VERBATIM)
endif()
