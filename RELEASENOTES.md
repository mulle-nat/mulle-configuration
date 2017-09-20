### 3.1.2

* rename MulleTests.cmake to MulleTest.cmake

### 3.1.1

* Various small improvements

## 3.1

* add mulle-tests support to mulle-configuration
* extract mulle-bootstrap specific stuff, making it optional opt-out

### 3.0.1

* inherit definitions properly using CMakeDependencies.txt and not via hacks in Standalone

# 3.0.0

* Added Standalone.cmake and DependenciesIncObjC.cmake for often used functionality
* move Xcode files into own subdirectory
* C:/Program Files/Git/WHOLEARCHIVE option for mingw. FORCE_LOAD is now a FORCE_LOAD_PREFIX
* Added OptimizedLinkObjC.cmake and ExecutableObjC.cmake to simplify mulle-objc-init

### 2.0.1

* fixes for mingw

### 2.0.0

** use FORCE_LOAD on OS X, BEGIN_ALL_LOAD on Linux and others

# 1.1.1

* Don't produce a formula for this
* set CMAKE_FIND_ROOT_PATH

# 1.0.1

* Finally versioned this.
* Moved all cmake files into cmake directory.So change 'set( CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_SOURCE_DIR}/mulle-configuration)' to 'set( CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_SOURCE_DIR}/mulle-configuration/cmake)' in your CMakeLists.txt files
