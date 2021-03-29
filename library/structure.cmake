macro(get_library_name _result)
    get_last_dirname("${CMAKE_CURRENT_SOURCE_DIR}" "${_result}")
endmacro()

macro(get_library_name_uppercase _result)
    get_last_dirname("${CMAKE_CURRENT_SOURCE_DIR}" "${_result}")
    string(TOUPPER ${${_result}} ${_result})
    string(REPLACE "-" "_" ${_result} ${${_result}})
endmacro()

macro(get_library_include _result)
    set(${_result} "${CMAKE_CURRENT_SOURCE_DIR}/${ADDON_LIBRARY_INCLUDE_DIR}")
endmacro()

macro(get_library_include_dir _result)
    set(${_result} "${CMAKE_CURRENT_SOURCE_DIR}/${ADDON_LIBRARY_INCLUDE_DIR}/${PROJECT_NAME}")
endmacro()

macro(get_library_source_dir _result)
    set(${_result} "${CMAKE_CURRENT_SOURCE_DIR}/${ADDON_LIBRARY_SOURCE_DIR}")
endmacro()

macro(get_library_tests_dir _result)
    set(${_result} "${CMAKE_CURRENT_SOURCE_DIR}/${ADDON_LIBRARY_TESTS_DIR}")
endmacro()

macro(collect_library_headers _include_path _result)
    file(GLOB_RECURSE ${_result} ${_include_path}/*.h)
endmacro()

macro(collect_library_sources _source_path _result)
    file(GLOB_RECURSE ${_result} ${_source_path}/*.cpp)
endmacro()

macro(collect_library_tests _tests_path _result)
    file(GLOB_RECURSE ${_result} ${_tests_path}/*.cpp)
endmacro()

macro(collect_library_version _include_path)
    configure_file(${_include_path}/version.h.in ${CMAKE_CURRENT_BINARY_DIR}/version.h @ONLY)
endmacro()

macro(library_include_private_headers _include_path)
    target_include_directories(
        ${PROJECT_NAME}
            PRIVATE
                $<BUILD_INTERFACE:${_include_path}>
                $<INSTALL_INTERFACE:include/${PROJECT_NAME}>)
endmacro()

macro(library_include_public_headers _include)
    target_include_directories(
        ${PROJECT_NAME}
            PUBLIC
                $<BUILD_INTERFACE:${_include}>
                $<INSTALL_INTERFACE:include}>)
endmacro()