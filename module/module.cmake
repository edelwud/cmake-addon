macro(create_module)
  set(oneValueArgs TYPE DESCRIPTION VERSION)
  set(multiValueArgs DEPENDENCIES EXPORT)
  cmake_parse_arguments(MODULE "" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})

  get_module_name(MODULE_NAME)
  get_module_name_uppercase(MODULE_NAME_UPPERCASE)

  project(
    ${MODULE_NAME}
    VERSION "${MODULE_VERSION}"
    DESCRIPTION "${MODULE_DESCRIPTION}"
  )

  set(MODULE_INCLUDE "${CMAKE_CURRENT_SOURCE_DIR}/${ADDON_MODULE_INCLUDE_DIR}")
  set(MODULE_INCLUDE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/${ADDON_MODULE_INCLUDE_DIR}/${PROJECT_NAME}")
  set(MODULE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/${ADDON_MODULE_SOURCE_DIR}")
  set(MODULE_TESTS_DIR "${CMAKE_CURRENT_SOURCE_DIR}/${ADDON_MODULE_TESTS_DIR}")

  validate_module()
  configure_file(${ADDON_PATH}/templates/version.h.in ${CMAKE_CURRENT_BINARY_DIR}/version.h @ONLY)

  collect_module_headers("${MODULE_INCLUDE_DIR}" "MODULE_HEADERS")
  collect_module_sources("${MODULE_SOURCE_DIR}" "MODULE_SOURCES")

  if(${MODULE_TYPE} STREQUAL executable)
    add_executable(${MODULE_NAME} ${MODULE_HEADERS} ${MODULE_SOURCES})
    module_install(${MODULE_INCLUDE_DIR} NO NO ${MODULE_DEPENDENCIES})
  elseif(${MODULE_TYPE} STREQUAL library)
    add_library(${MODULE_NAME} SHARED ${MODULE_HEADERS} ${MODULE_SOURCES})

    set(oneValueArgs PKGCONF CMAKE)
    cmake_parse_arguments(EXPORTS "" "${oneValueArgs}" "" ${MODULE_EXPORT})
    module_install(${MODULE_INCLUDE_DIR} ${EXPORTS_PKGCONF} ${EXPORTS_CMAKE} ${MODULE_DEPENDENCIES})
  elseif(${MODULE_TYPE} STREQUAL library_static)
    add_library(${MODULE_NAME} ${MODULE_HEADERS} ${MODULE_SOURCES})

    set(oneValueArgs PKGCONF CMAKE)
    cmake_parse_arguments(EXPORTS "" "${oneValueArgs}" "" ${MODULE_EXPORT})
    module_install(${MODULE_INCLUDE_DIR} ${EXPORTS_PKGCONF} ${EXPORTS_CMAKE} ${MODULE_DEPENDENCIES})
  endif()

  if(DEFINED MODULE_DEPENDENCIES)
    target_link_libraries(${MODULE_NAME} PRIVATE ${MODULE_DEPENDENCIES})
  endif()
  set_target_properties(${MODULE_NAME} PROPERTIES LINKER_LANGUAGE CXX)

  module_include_private_headers(${MODULE_INCLUDE_DIR})
  module_include_public_headers(${MODULE_INCLUDE})

  create_module_tests(${MODULE_DEPENDENCIES})
endmacro()

macro(create_module_tests)
  collect_module_tests("${MODULE_TESTS_DIR}" "MODULE_TESTS")

  set(MODULE_TESTS_NAME "test_${PROJECT_NAME}")
  add_executable(${MODULE_TESTS_NAME} ${MODULE_TESTS})

  target_link_libraries(${MODULE_TESTS_NAME} ${ARGN} ${ADDON_DEV_DEPS})
  if(${MODULE_TYPE} MATCHES library)
    target_link_libraries(${MODULE_TESTS_NAME} ${PROJECT_NAME})
  endif()
endmacro()


macro(validate_module)
  if (NOT EXISTS "${MODULE_INCLUDE_DIR}")
    message(FATAL_ERROR "Module ${MODULE_NAME} should contain \"${MODULE_INCLUDE_DIR}\" directory")
  endif()

  if (NOT EXISTS "${MODULE_SOURCE_DIR}")
    message(FATAL_ERROR "Module ${MODULE_NAME} should contain \"${MODULE_SOURCE_DIR}\" directory")
  endif()

  if (NOT EXISTS "${MODULE_TESTS_DIR}")
    message(FATAL_ERROR "Module ${MODULE_NAME} should contain \"${MODULE_TESTS_DIR}\" directory")
  endif()
endmacro()