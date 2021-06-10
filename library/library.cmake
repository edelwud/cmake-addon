macro(create_library _version _desc)
    get_library_name(LIBRARY_NAME)
    get_library_name_uppercase(LIBRARY_NAME_UPPERCASE)

    project(${LIBRARY_NAME}
            VERSION "${_version}"
            DESCRIPTION  "${_desc}")

    get_library_include(LIBRARY_INCLUDE)
    get_library_include_dir(LIBRARY_INCLUDE_DIR)
    get_library_source_dir(LIBRARY_SOURCE_DIR)
    collect_library_version(${CMAKE_CURRENT_SOURCE_DIR})
    collect_library_headers("${LIBRARY_INCLUDE_DIR}" "LIBRARY_HEADERS")
    collect_library_sources("${LIBRARY_SOURCE_DIR}" "LIBRARY_SOURCES")

    add_library(${LIBRARY_NAME} ${LIBRARY_HEADERS} ${LIBRARY_SOURCES})
    target_link_libraries(${LIBRARY_NAME} PRIVATE ${ARGN})
    set_target_properties(${LIBRARY_NAME} PROPERTIES LINKER_LANGUAGE CXX)

    library_include_private_headers(${LIBRARY_INCLUDE_DIR})
    library_include_public_headers(${LIBRARY_INCLUDE})
    library_install("${LIBRARY_INCLUDE_DIR}")

    create_library_tests()
endmacro()

macro(create_library_tests)
    get_library_tests_dir(LIBRARY_TESTS_DIR)
    collect_library_tests("${LIBRARY_TESTS_DIR}" "LIBRARY_TESTS")

    set(LIBRARY_TESTS_NAME "test_${PROJECT_NAME}")
    add_executable(${LIBRARY_TESTS_NAME} ${LIBRARY_TESTS})

    target_link_libraries(${LIBRARY_TESTS_NAME} ${PROJECT_NAME} gtest)
endmacro()