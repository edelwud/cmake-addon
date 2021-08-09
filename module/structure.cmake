macro(get_module_name _result)
  get_last_dirname("${CMAKE_CURRENT_SOURCE_DIR}" "${_result}")
endmacro()

macro(get_module_name_uppercase _result)
  get_last_dirname("${CMAKE_CURRENT_SOURCE_DIR}" "${_result}")
  string(TOUPPER ${${_result}} ${_result})
  string(REPLACE "-" "_" ${_result} ${${_result}})
endmacro()

macro(collect_module_headers _include_path _result)
  file(GLOB_RECURSE ${_result} ${_include_path}/*.h*)
endmacro()

macro(collect_module_sources _source_path _result)
  file(GLOB_RECURSE ${_result} ${_source_path}/*.c*)
endmacro()

macro(collect_module_tests _tests_path _result)
  file(GLOB_RECURSE ${_result} ${_tests_path}/*.c*)
endmacro()

macro(module_include_private_headers _include_path)
  target_include_directories(
    ${PROJECT_NAME} PRIVATE $<BUILD_INTERFACE:${_include_path}>
                            $<INSTALL_INTERFACE:include/${PROJECT_NAME}>)
endmacro()

macro(module_include_public_headers _include)
  target_include_directories(
    ${PROJECT_NAME} PUBLIC $<BUILD_INTERFACE:${_include}>
                           $<INSTALL_INTERFACE:include}>)
endmacro()
