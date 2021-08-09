find_package(Doxygen)

if(DOXYGEN_FOUND)
  set(DOXYGEN_IN ${ADDON_PATH}/templates/Doxyfile.in)
  set(DOXYGEN_OUT ${CMAKE_SOURCE_DIR}/${ADDON_DOCS}/Doxyfile)

  configure_file(${DOXYGEN_IN} ${DOXYGEN_OUT} @ONLY)
  message("Doxygen build started")

  add_custom_target(
    autodoc ALL
    COMMAND ${DOXYGEN_EXECUTABLE} ${DOXYGEN_OUT}
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/${ADDON_DOCS}
    COMMENT "Generating API documentation with Doxygen"
    VERBATIM)
else(DOXYGEN_FOUND)
  message("Doxygen need to be installed to generate the doxygen documentation")
endif(DOXYGEN_FOUND)
