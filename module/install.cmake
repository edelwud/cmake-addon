macro(module_install_headers _include_dir)
  install(
    TARGETS ${PROJECT_NAME}
    EXPORT ${ADDON_APP}Targets
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
    INCLUDES
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/${ADDON_APP}
    PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/${ADDON_APP}
  )
  install(DIRECTORY ${_include_dir} DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/${ADDON_APP})
endmacro()

macro(module_project_properties)
  set_target_properties(
    ${PROJECT_NAME}
    PROPERTIES VERSION ${PROJECT_VERSION}
               SOVERSION ${PROJECT_VERSION_MAJOR}
               INTERFACE_${PROJECT_NAME}_MAJOR_VERSION ${PROJECT_VERSION_MAJOR}
               COMPATIBLE_INTERFACE_STRING ${PROJECT_VERSION_MAJOR}
  )
endmacro()

macro(modules_install_cmake_config)
  module_project_properties()

  export(EXPORT ${ADDON_APP}Targets FILE "${ADDON_MODULE_PACKAGES_DIR}/${PROJECT_NAME}.cmake")

  include(CMakePackageConfigHelpers)

  configure_package_config_file(
    ${CMAKE_SOURCE_DIR}/${ADDON_DIRNAME}/templates/module.cmake.in
    "${ADDON_MODULE_PACKAGES_DIR}/${ADDON_APP}Config.cmake"
    INSTALL_DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${ADDON_APP}
  )

  write_basic_package_version_file(
    "${ADDON_MODULE_PACKAGES_DIR}/${ADDON_APP}ConfigVersion.cmake"
    VERSION ${PROJECT_VERSION}
    COMPATIBILITY SameMajorVersion
  )

  install(
    EXPORT ${ADDON_APP}Targets
    NAMESPACE ${ADDON_APP}::
    DESTINATION lib/cmake/${ADDON_APP}
  )

  install(
    FILES "${ADDON_MODULE_PACKAGES_DIR}/${ADDON_APP}Config.cmake"
          "${ADDON_MODULE_PACKAGES_DIR}/${ADDON_APP}ConfigVersion.cmake"
    DESTINATION lib/cmake/${ADDON_APP}
  )
endmacro()

macro(module_install_pkg_config)
  set(includedir ${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_INCLUDEDIR})
  set(libdir ${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR})
  set(prefix ${CMAKE_INSTALL_PREFIX})

  configure_file(
    ${ADDON_PATH}/templates/module.pc.in ${CMAKE_CURRENT_BINARY_DIR}/${MODULE_NAME}.pc @ONLY
  )

  install(FILES ${CMAKE_CURRENT_BINARY_DIR}/${MODULE_NAME}.pc
          DESTINATION ${CMAKE_INSTALL_LIBDIR}/pkgconfig
  )
endmacro()

macro(module_install _include_dir _pkgconf _cmake)
  if(${MODULE_TYPE} MATCHES library)
    if(${_cmake})
      module_install_headers(${_include_dir})
    endif()
    if(${_pkgconf})
      module_install_pkg_config(${ARGN})
    endif()
  endif()
endmacro()
