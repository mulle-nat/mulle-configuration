#
# Input:
#
# STANDALONE_BASE_NAME
# STANDALONE_ALL_LOAD_LIBRARIES
#
# Optional:
#
# STANDALONE_NAME
# STANDALONE_DEFINITIONS
# STANDALONE_SOURCE
# STANDALONE_SYMBOL_PREFIXES
# STANDALONE_NORMAL_LOAD_LIBRARIES
# MULLE_LANGUAGE
#
set( STANDALONE_VERSION 3)

if( NOT STANDALONE_NAME)
   set( STANDALONE_NAME "${STANDALONE_BASE_NAME}Standalone")
endif()

#
# Required empty standalone source file
#
if( NOT STANDALONE_SOURCE)
   if( "${MULLE_LANGUAGE}" MATCHES "ObjC")
      set( STANDALONE_SOURCE "src/${STANDALONE_NAME}.m")
   else()
      set( STANDALONE_SOURCE "src/${STANDALONE_NAME}.c")
   endif()
else()
   if( "${STANDALONE_SOURCE}" MATCHES "-")
      unset( STANDALONE_SOURCE)
   endif()
endif()

#
# symbol prefixes to export on Windows, ignored on other platforms
#
if( NOT STANDALONE_SYMBOL_PREFIXES)
   set( STANDALONE_SYMBOL_PREFIXES "mulle"
           "_mulle"
   )

  if( "${MULLE_LANGUAGE}" MATCHES "ObjC")
      set( STANDALONE_SYMBOL_PREFIXES
         ${STANDALONE_SYMBOL_PREFIXES}
         "Mulle"
         "ns"
         "NS"
         "_Mulle"
         "_ns"
         "_NS"
      )
  endif()
endif()


foreach( library ${STANDALONE_ALL_LOAD_LIBRARIES})
   list( APPEND STANDALONE_FORCE_ALL_LOAD_LIBRARIES "${FORCE_LOAD_PREFIX}${library}")
endforeach()

foreach( prefix ${STANDALONE_SYMBOL_PREFIXES})
   list( APPEND STANDALONE_DUMPDEF_SYMBOL_PREFIXES "--prefix")
   list( APPEND STANDALONE_DUMPDEF_SYMBOL_PREFIXES "${prefix}")
endforeach()

#
# Standalone
#
if( MSVC)
   set( DEF_FILE "${STANDALONE_NAME}.def")
   set_source_files_properties( ${DEF_FILE} PROPERTIES HEADER_FILE_ONLY TRUE)
   set( CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS OFF)
   set( CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} /DEF:${DEF_FILE}")

   message( STATUS "MSVC will generate \"${DEF_FILE}\" from ${TARGET_ALL_LOAD_LIBRARIES}")

   add_custom_command( OUTPUT ${DEF_FILE}
                       COMMAND mulle-mingw-dumpdef.bat -o "${DEF_FILE}"
                               --directory "${BUILD_RELATIVE_DEPENDENCIES_DIR}/lib"
                               ${STANDALONE_DUMPDEF_SYMBOL_PREFIXES}
                               ${STANDALONE_ALL_LOAD_LIBRARIES}
                       DEPENDS ${STANDALONE_ALL_LOAD_LIBRARIES}
                       VERBATIM)
   find_program( CREATE_INC mulle-objc-create-dependencies-inc.bat ${DEPENDENCIES_DIR}/bin)
endif()


add_library( ${STANDALONE_NAME} SHARED
${STANDALONE_SOURCE}
${DEF_FILE}
)

# PRIVATE is a guess
target_compile_definitions( ${STANDALONE_NAME}
PRIVATE ${STANDALONE_DEFINITIONS}
)

add_dependencies( ${STANDALONE_NAME} ${STANDALONE_BASE_NAME})


#
# If you add DEPENDENCY_LIBRARIES to the static, adding them again to
# MulleObjCStandardFoundationStandalone confuses cmake it seems. But they are
# implicitly added.
#
target_link_libraries( ${STANDALONE_NAME}
${BEGIN_ALL_LOAD}
${STANDALONE_FORCE_ALL_LOAD_LIBRARIES}
${END_ALL_LOAD}
${STANDALONE_NORMAL_LOAD_LIBRARIES}
)

