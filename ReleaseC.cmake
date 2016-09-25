#
# Set Search Paths
#


#
# Set Compiler Flags
#
if( MULLE_C_COMPILER_ID MATCHES "^(Intel|MSVC|MSVC-Clang|MSVC-MulleClang)$")
   set( OTHER_C_FLAGS "${OTHER_C_FLAGS} /O2 /Zo /DNDEBUG=1 ${UNWANTED_C_WARNINGS}")
else()
   set( OTHER_C_FLAGS "${OTHER_C_FLAGS} -O3 -DNDEBUG=1 ${UNWANTED_C_WARNINGS}")
endif()


#
# Set Linker Flags
#