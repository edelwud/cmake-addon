cpmaddpackage("gh:StableCoder/cmake-scripts#21.01")

set(CLANG_TIDY ON)

include(${cmake-scripts_SOURCE_DIR}/formatting.cmake)
include(${cmake-scripts_SOURCE_DIR}/tools.cmake)
include(${cmake-scripts_SOURCE_DIR}/sanitizers.cmake)

clang_tidy(${CLANG_TIDY_ARGS})

file(GLOB_RECURSE LIBS_SOURCES ${ADDON_LIBS_PATH}/**/*.c*)
file(GLOB_RECURSE LIBS_HEADERS ${ADDON_LIBS_PATH}/**/*.h*)
file(GLOB_RECURSE APP_SOURCES ${ADDON_APP_PATH}/**/*.c*)
file(GLOB_RECURSE APP_HEADERS ${ADDON_APP_PATH}/**/*.h*)

file(GLOB_RECURSE CMAKE_CODE *.cmake)
file(GLOB_RECURSE CMAKE_BUILD_CODE ${CMAKE_SOURCE_DIR}/build/**/*.cmake)
foreach(BUILD_CMAKE ${CMAKE_BUILD_CODE})
  list(REMOVE_ITEM CMAKE_CODE ${BUILD_CMAKE})
endforeach()

clang_format(clang-format ${APP_HEADERS} ${APP_SOURCES} ${LIBS_HEADERS}
             ${LIBS_SOURCES})
cmake_format(cmake-format ${CMAKE_CODE})
