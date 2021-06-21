macro(initialize_project _source_path)
  string(TOUPPER ${PROJECT_NAME} PROJECT_NAME_UPPERCASE)
  string(REPLACE "-" "_" PROJECT_NAME_UPPERCASE ${PROJECT_NAME_UPPERCASE})

  set(ADDON_SOURCE_DIR "${PROJECT_NAME}")

  add_subdirectory(${ADDON_LIBS_DIR})
  add_subdirectory(${ADDON_SOURCE_DIR})
endmacro()
