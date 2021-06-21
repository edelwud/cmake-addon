macro(version_configure _dirpath)
  configure_file("${_dirpath}/version.h.in" "${CMAKE_CURRENT_BINARY_DIR}/version.h" @ONLY)
endmacro()
