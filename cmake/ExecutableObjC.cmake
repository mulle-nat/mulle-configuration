#
# Input:
#
# EXECUTABLE_BASE_NAME
# EXECUTABLE_ALL_LOAD_LIBRARIES
#
#
# Optional:
#
# EXECUTABLE_OPTIMIZABLE_LOAD_LIBRARIES
# C_DEPENDENCY_LIBRARIES
# OS_SPECIFIC_LIBRARIES
#
set( EXECUTABLE_VERSION 3)

foreach( library ${EXECUTABLE_ALL_LOAD_LIBRARIES})
   list( APPEND EXECUTABLE_FORCE_ALL_LOAD_LIBRARIES "${FORCE_LOAD_PREFIX}${library}")
endforeach()

###

target_link_libraries( "${EXECUTABLE_NAME}"
${BEGIN_ALL_LOAD}
${EXECUTABLE_FORCE_ALL_LOAD_LIBRARIES}
${END_ALL_LOAD}
${EXECUTABLE_NORMAL_LOAD_LIBRARIES}
${C_DEPENDENCY_LIBRARIES}
${OS_SPECIFIC_LIBRARIES}
)
