macro(initialize_project)
  include(${ADDON_DIRNAME}/doxygen.cmake)
  include(GNUInstallDirs)

  add_subdirectory(${ADDON_LIBS})
  add_subdirectory(${ADDON_APP})

  modules_install_cmake_config()
endmacro()
