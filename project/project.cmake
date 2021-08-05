macro(initialize_project)
  include(GNUInstallDirs)

  include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
  conan_basic_setup(TARGETS)

  add_subdirectory(${ADDON_LIBS})
  add_subdirectory(${ADDON_APP})
endmacro()
