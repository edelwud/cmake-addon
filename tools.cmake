# Copies file before selected target builds
macro(COPY_FILE_BEFORE_BUILD target filepath_in filepath_out)
  addon_debug(
    "TARGET ${target} COPY FILE FROM ${filepath_in} TO ${filepath_out}")
  add_custom_command(
    TARGET ${target}
    PRE_BUILD
    COMMENT File copy
    COMMAND ${CMAKE_COMMAND} -E copy ${filepath_in} ${filepath_out})
endmacro(COPY_FILE_BEFORE_BUILD)

# Copies directory before selected target builds
macro(COPY_DIR_BEFORE_BUILD target dirpath_in dirpath_out)
  addon_debug("TARGET ${target} COPY DIR FROM ${dirpath_in} TO ${dirpath_out}")
  add_custom_command(
    TARGET ${target}
    PRE_BUILD
    COMMENT Directory copy
    COMMAND ${CMAKE_COMMAND} -E copy_directory ${dirpath_in} ${dirpath_out})
endmacro(COPY_DIR_BEFORE_BUILD)

# Gets parent name from current directory
macro(GET_PARENT_DIRNAME dirname)
  get_filename_component(${dirname} ${CMAKE_CURRENT_SOURCE_DIR} NAME_WLE)
endmacro(GET_PARENT_DIRNAME)

# Gets parent name from passed directory
macro(GET_LAST_DIRNAME path dirname)
  get_filename_component(${dirname} ${path} NAME_WLE)
endmacro(GET_LAST_DIRNAME)

# Gets all defined targets
function(get_all_targets var)
  set(targets)
  get_all_targets_recursive(targets ${CMAKE_CURRENT_SOURCE_DIR})
  set(${var}
      ${targets}
      PARENT_SCOPE)
endfunction(get_all_targets)

# Recursive scan targets
macro(GET_ALL_TARGETS_RECURSIVE targets dir)
  get_property(
    subdirectories
    DIRECTORY ${dir}
    PROPERTY SUBDIRECTORIES)
  foreach(subdir ${subdirectories})
    get_all_targets_recursive(${targets} ${subdir})
  endforeach()

  get_property(
    current_targets
    DIRECTORY ${dir}
    PROPERTY BUILDSYSTEM_TARGETS)
  list(APPEND ${targets} ${current_targets})
endmacro()
