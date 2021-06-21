CPMAddPackage("gh:StableCoder/cmake-scripts#21.01")

set(CLANG_TIDY ON)

include(${cmake-scripts_SOURCE_DIR}/formatting.cmake)
include(${cmake-scripts_SOURCE_DIR}/tools.cmake)
include(${cmake-scripts_SOURCE_DIR}/sanitizers.cmake)

clang_tidy(${CLANG_TIDY_ARGS})

file(GLOB_RECURSE LIBS_SOURCES ${CMAKE_CURRENT_SOURCE_DIR}/libs/**/*.cpp)
file(GLOB_RECURSE LIBS_HEADERS ${CMAKE_CURRENT_SOURCE_DIR}/libs/**/**/*.h)
file(GLOB_RECURSE APP_SOURCES ${CMAKE_CURRENT_SOURCE_DIR}/${PROJECT_NAME}/**/*.cpp)
file(GLOB_RECURSE APP_HEADERS ${CMAKE_CURRENT_SOURCE_DIR}/${PROJECT_NAME}/**/**/*.h)

file(GLOB_RECURSE CMAKE_CODE *.cmake)

clang_format(clang-format ${APP_HEADERS} ${APP_SOURCES} ${LIBS_HEADERS} ${LIBS_SOURCES})
cmake_format(cmake-format ${CMAKE_CODE})
