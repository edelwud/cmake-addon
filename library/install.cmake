macro(library_install_headers _include_dir)
    install(TARGETS ${PROJECT_NAME} EXPORT ${PROJECT_NAME}Targets
            ARCHIVE  DESTINATION ${CMAKE_INSTALL_LIBDIR}
            LIBRARY  DESTINATION ${CMAKE_INSTALL_LIBDIR}
            RUNTIME  DESTINATION ${CMAKE_INSTALL_BINDIR}
            INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
            PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
            )
    install(DIRECTORY ${_include_dir} DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})
endmacro()

macro(library_install_export_headers)
    include(GenerateExportHeader)
    generate_export_header(${PROJECT_NAME}
            EXPORT_MACRO_NAME EXPORT
            NO_EXPORT_MACRO_NAME NO_EXPORT
            PREFIX_NAME ${PROJECT_NAME}_
            EXPORT_FILE_NAME ${CMAKE_BINARY_DIR}/${ADDON_LIBRARY_INCLUDE_EXPORTS_DIR}/${PROJECT_NAME}/export.h)
    install(DIRECTORY ${CMAKE_BINARY_DIR}/${ADDON_LIBRARY_INCLUDE_EXPORTS_DIR}/ DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})
endmacro()

macro(library_project_properties)
    set_property(TARGET ${PROJECT_NAME} PROPERTY VERSION ${PROJECT_VERSION})
    set_property(TARGET ${PROJECT_NAME} PROPERTY SOVERSION ${PROJECT_VERSION_MAJOR})
    set_property(TARGET ${PROJECT_NAME} PROPERTY INTERFACE_${PROJECT_NAME}_MAJOR_VERSION ${PROJECT_VERSION_MAJOR})
    set_property(TARGET ${PROJECT_NAME} APPEND PROPERTY COMPATIBLE_INTERFACE_STRING ${PROJECT_VERSION_MAJOR})
endmacro()

macro(library_install_cmake_config _include_dir)
    include(CMakePackageConfigHelpers)

    library_project_properties()

    write_basic_package_version_file(
            "${ADDON_LIBRARY_PACKAGES_DIR}/${PROJECT_NAME}ConfigVersion.cmake"
            VERSION ${PROJECT_VERSION}
            COMPATIBILITY SameMajorVersion)

    export(EXPORT ${PROJECT_NAME}Targets
            FILE "${CMAKE_BINARY_DIR}/CMakePackage/${PROJECT_NAME}.cmake")

    SET(CONFIG_SOURCE_DIR ${CMAKE_SOURCE_DIR})
    SET(CONFIG_DIR ${CMAKE_BINARY_DIR})
    SET(${PROJECT_NAME}_INCLUDE_DIR "${_include_dir}")
    configure_package_config_file(
            ${CMAKE_SOURCE_DIR}/cmake/Config.cmake.in
            "${ADDON_LIBRARY_PACKAGES_DIR}/${PROJECT_NAME}Config.cmake"
            INSTALL_DESTINATION lib/cmake/${PROJECT_NAME}
            PATH_VARS ${PROJECT_NAME}_INCLUDE_DIR)

    install(EXPORT ${PROJECT_NAME}Targets
            FILE ${PROJECT_NAME}.cmake
            DESTINATION lib/cmake/${PROJECT_NAME})

    install(FILES
                "${ADDON_LIBRARY_PACKAGES_DIR}/${PROJECT_NAME}Config.cmake"
                "${ADDON_LIBRARY_PACKAGES_DIR}/${PROJECT_NAME}ConfigVersion.cmake"
            DESTINATION lib/cmake/${PROJECT_NAME}
            COMPONENT Devel)
endmacro()

macro(library_install _include_dir)
    library_install_headers(${_include_dir})
    library_install_export_headers()
    library_install_cmake_config(${_include_dir})
endmacro()