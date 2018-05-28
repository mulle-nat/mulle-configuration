# THIS PROJECT HAS BEEN SUPERSEDED BY MULLE-SDE-DEVELOPER

[mulle-sde-developer](//github.com/mulle-sde/mulle-sde-developer)


## cmake includes

This project contains some common definitions for cmake to make `CMakeLists.txt`
more uniform and simpler. Check this repo out besides `CMakeLists.txt` and
add the following lines:

```
set( CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_SOURCE_DIR}/mulle-configuration/cmake)
if( "${CMAKE_BUILD_TYPE}" STREQUAL "Debug")
  include( Debug)
else()
  include( Release)
endif()
```

## What it does

* Adds `-fPIC` or similiar flag for platforms that need it
* Specifies `OS_SPECIFIC_LIBRARIES` for `thread` and `dlopen` libraries
* Specifies `BEGIN_ALL_LOAD` and `END_ALL_LOAD` to envelope static library linkage, whose unused symbols must not be optimized away by the linker
* If not called from mulle-bootstrap, it discovers `DEPENDENCIES_DIR` and `ADDICTIONS_DIR` and  updates `CMAKE_FRAMEWORK_PATH`, `CMAKE_LIBRARY_PATH` and `include_directories`
* Also removes some unwanted warnings from C and ObjC

## what it does not

* It's no good changing the compiler within `CMakeLists.txt`, so this is not attempted.


## Xcode configurations

These configurations are embedded into various projects, probably using
`mulle-bootstrap`. Confusingly they aren't really identical to the cmake stuff.
They might just go away.

### How to embed

```console
$ mulle-bootstrap init
$ echo "http://www.mulle-kybernetik.com/repositories/mulle-configuration" >> .bootstrap/embedded_repositories
$ mulle-bootstrap fetch
```

### Customizing them for your project

```console
$ git branch <myproject>
$ git checkout <myproject>
$ mkdir -p .bootstrap/settings/mulle-configuration
$ echo "<myproject> > .bootstrap/settings/mulle-configuration/tag
$ git push --all
```

