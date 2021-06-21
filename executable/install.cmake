macro(executable_install_headers _include_dir)
  install(
    TARGETS ${PROJECT_NAME}
    EXPORT ${PROJECT_NAME}Targets
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
    INCLUDES
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
    PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
  )
  install(DIRECTORY ${_include_dir} DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})
endmacro()

macro(executable_install _include_dir)
  executable_install_headers(${_include_dir})
endmacro()
