# CMake Addon
CMake Addon production ready extension for C/C++ project making it easy to split 
the project into modules and submodules which are dynamic and static libraries, 
includes package manager CPM & Conan, doxygen docs system, 
provides useful build/install systems and test system.

## Motivation
* Standardize of the C/C++ project structure
* Reduce the number of instructions for building a project
* Improve the internal organization of the project
* Improve support for modern coding standards
* Improve module reusability
* Improve convenience TDD
* Improve CPack integration
* Improve library & executable versioning
* Make it easy to set up a project building & installation
* Add support for auto-generated documentation
* Add capability for dockerization
* Add automated formatting of C/C++ & CMake code (integrate clang-format & cmake-format)
* Add CMake & pkg-config integration
* Use improved package manager Conan

## Module structure
```
+ <library-name>
    + include (defenitions)
        + <library-name>
            - header.h
            - ...
    + src
        - source.cpp
        - ...
    + tests
        - main.cpp
        - test_xxx.cpp
    - CMakeLists.txt
    - version.h.in
```
* Name of module will be equal to _<library-name>_
* CMakeLists.txt contains module declaration
* Module should contain following dirs:
    * include
    * include/<library-name>
    * src
    * tests
* _version.h.in_ contains module version macros that can be used to identify version of module

## Module declaration
```cmake
create_module(
        TYPE library_static # or library (shared), or executable
        VERSION 0.0.1
        DESCRIPTION Logging module
        DEPENDENCIES CONAN_PKG::magic_enum # libraries that links to module
        EXPORT # make sense only for libraries
            CMAKE NO # install module and export binaries via cmake 
            PKGCONF YES # install module and export binaries via pkg-config
)
```
* Module __TYPE__ divides into 3 types: library (shared library, DLL), 
  library_static (static library), executable (ELF, EXE)
* __VERSION__ helps to identify version of every single module
* __DESCRIPTION__ used to generate description for package
* __DEPENDENCIES__ links other modules & libraries to current module
* __EXPORT__ label generates CMake & pkg-config files that helps 
  to find packages and single components
  * __CMAKE__ label exports module as CMake package
  * __PKGCONF__ label exports module as pkg-config package
  
## Usage
* Recommended to use cmake addon as a git submodule
```bash
git submodule add https://github.com/edelwud/cmake-addon cmake
```
* Need to add `cmake/main.cmake` file to root CMakeLists.txt file
```cmake
include(cmake/main.cmake)
```
* Recommended to use CMake `initialize_project` function in root CMakeLists.txt file
```cmake
initialize_project(${CMAKE_CURRENT_SOURCE_DIR})
```
* `<application-name>` directory in root should contain executable module, 
  `libs` directory in root should contain library modules which includes into project with
  `add_subdirectory` function
  
<hr>

_LICENSE GPL-3.0_