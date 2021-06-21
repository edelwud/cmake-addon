# PATH
set(CMAKE_ADDON_DIR cmake)
set(CMAKE_ADDON_PATH ${CMAKE_CURRENT_SOURCE_DIR}/${CMAKE_ADDON_DIR})

file(GLOB_RECURSE CMAKE_CONFIGS ${CMAKE_ADDON_PATH}/**/*.cmake)
list(APPEND CMAKE_CONFIGS "${CMAKE_ADDON_PATH}/defaults.cmake")
list(APPEND CMAKE_CONFIGS "${CMAKE_ADDON_PATH}/CPM.cmake")
list(APPEND CMAKE_CONFIGS "${CMAKE_ADDON_PATH}/external.cmake")
foreach(CMAKE ${CMAKE_CONFIGS})
  include(${CMAKE})
endforeach()

CPMAddPackage("gh:StableCoder/cmake-scripts#21.01")

set(CLANG_TIDY ON)

include(${cmake-scripts_SOURCE_DIR}/formatting.cmake)
include(${cmake-scripts_SOURCE_DIR}/tools.cmake)
include(${cmake-scripts_SOURCE_DIR}/sanitizers.cmake)

clang_tidy(${CLANG_TIDY_ARGS})

file(GLOB_RECURSE SOURCE_CODE *.cpp)
file(GLOB_RECURSE CMAKE_CODE *.cmake)

clang_format(clang-format ${SOURCE_CODE})
cmake_format(cmake-format ${CMAKE_CODE})
