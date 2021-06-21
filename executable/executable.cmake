macro(create_executable _version _desc)
  get_executable_name(EXECUTABLE_NAME)
  get_executable_name_uppercase(EXECUTABLE_NAME_UPPERCASE)

  project(
    ${EXECUTABLE_NAME}
    VERSION "${_version}"
    DESCRIPTION "${_desc}"
  )

  get_executable_include(EXECUTABLE_INCLUDE)
  get_executable_include_dir(EXECUTABLE_INCLUDE_DIR)
  get_executable_source_dir(EXECUTABLE_SOURCE_DIR)
  collect_executable_version(${CMAKE_CURRENT_SOURCE_DIR})
  collect_executable_headers("${EXECUTABLE_INCLUDE_DIR}" "EXECUTABLE_HEADERS")
  collect_executable_sources("${EXECUTABLE_SOURCE_DIR}" "EXECUTABLE_SOURCES")

  add_executable(${EXECUTABLE_NAME} ${EXECUTABLE_HEADERS} ${EXECUTABLE_SOURCES})
  target_link_libraries(${EXECUTABLE_NAME} PRIVATE ${ARGN})
  set_target_properties(${EXECUTABLE_NAME} PROPERTIES LINKER_LANGUAGE CXX)

  executable_include_private_headers(${EXECUTABLE_INCLUDE_DIR})
  executable_include_public_headers(${EXECUTABLE_INCLUDE})
  executable_install("${EXECUTABLE_INCLUDE_DIR}")

  create_executable_tests(${ARGN})
endmacro()

macro(create_executable_tests)
  get_executable_tests_dir(EXECUTABLE_TESTS_DIR)
  collect_executable_tests("${EXECUTABLE_TESTS_DIR}" "EXECUTABLE_TESTS")

  set(EXECUTABLE_TESTS_NAME "test_${PROJECT_NAME}")
  add_executable(${EXECUTABLE_TESTS_NAME} ${EXECUTABLE_TESTS})

  target_link_libraries(${EXECUTABLE_TESTS_NAME} ${ARGN} gtest)
endmacro()
