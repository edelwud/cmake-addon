set(ADDON_DIRNAME cmake)
set(ADDON_PATH ${CMAKE_SOURCE_DIR}/${ADDON_DIRNAME})
if(NOT EXISTS "${ADDON_PATH}")
  message(FATAL_ERROR "Change CMake Addon directory to `${ADDON_DIRNAME}`")
endif()

include(${ADDON_PATH}/tools.cmake)
include(${ADDON_PATH}/conan.cmake)
include(${ADDON_PATH}/CPM.cmake)
include(${ADDON_PATH}/predefines.cmake)


set(ADDON_DOCS_PATH ${CMAKE_SOURCE_DIR}/${ADDON_DOCS})
if(NOT EXISTS "${ADDON_DOCS_PATH}")
  message(FATAL_ERROR "Change name of docs directory to `${ADDON_DOCS}`")
endif()

set(ADDON_LIBS_PATH ${CMAKE_SOURCE_DIR}/${ADDON_LIBS})
if(NOT EXISTS "${ADDON_LIBS_PATH}")
  message(FATAL_ERROR "Change name of libs directory to `${ADDON_LIBS}`")
endif()

set(ADDON_APP_PATH ${CMAKE_SOURCE_DIR}/${ADDON_APP})
if(NOT EXISTS "${ADDON_APP_PATH}")
  message(FATAL_ERROR "Change name of app directory to `${ADDON_APP}`")
endif()

file(GLOB_RECURSE ADDON_CONFIGS ${ADDON_DIRNAME}/**/*.cmake)
list(APPEND ADDON_CONFIGS "${ADDON_DIRNAME}/defaults.cmake")
list(APPEND ADDON_CONFIGS "${ADDON_DIRNAME}/formatter.cmake")
foreach(CONFIG ${ADDON_CONFIGS})
  include(${CONFIG})
endforeach()
