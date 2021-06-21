# PATH
set(CMAKE_ADDON_DIR cmake)
set(CMAKE_ADDON_PATH ${CMAKE_CURRENT_SOURCE_DIR}/${CMAKE_ADDON_DIR})

include("${CMAKE_ADDON_PATH}/CPM.cmake")

file(GLOB_RECURSE CMAKE_CONFIGS ${CMAKE_ADDON_PATH}/**/*.cmake)
list(APPEND CMAKE_CONFIGS "${CMAKE_ADDON_PATH}/defaults.cmake")
list(APPEND CMAKE_CONFIGS "${CMAKE_ADDON_PATH}/external.cmake")
list(APPEND CMAKE_CONFIGS "${CMAKE_ADDON_PATH}/formatter.cmake")
foreach(CMAKE ${CMAKE_CONFIGS})
  include(${CMAKE})
endforeach()
