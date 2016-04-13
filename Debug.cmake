include( Common)

set( DEPENDENCY_FRAMEWORK_DIRS
dependencies/Frameworks/Debug
dependencies/Frameworks/Release
dependencies/Frameworks
)

set( DEPENDENCY_LIBRARY_DIRS
dependencies/lib/Debug
dependencies/lib/Release
dependencies/lib
)

link_directories(${CMAKE_BINARY_DIR}
dependencies/Frameworks/Debug
dependencies/Frameworks/Release
dependencies/Frameworks
dependencies/lib/Debug
dependencies/lib/Release
dependencies/lib
)

set(OTHER_C_FLAGS
-O0
-g
${UNWANTED_WARNINGS}
)

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -O0 -g -Wno-parentheses")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O0 -g -Wno-parentheses")

