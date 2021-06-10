macro(initialize_project _source_path)

    string(TOUPPER ${PROJECT_NAME} PROJECT_NAME_UPPERCASE)
    string(REPLACE "-" "_" PROJECT_NAME_UPPERCASE ${PROJECT_NAME_UPPERCASE})

    foreach(DEPENDENCY ${ADDON_EXTERNAL_DEPS})
#        hunter_add_package(${DEPENDENCY})
    endforeach()

    add_subdirectory(${ADDON_LIBS_DIR})
    add_subdirectory(${ADDON_SOURCE_DIR})
    add_subdirectory(${ADDON_TESTS_DIR})
endmacro()