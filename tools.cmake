macro(copy_file_before_build _target _filepath_in _filepath_out)
  addon_debug("TARGET ${_target} COPY FILE FROM ${_filepath_in} TO ${_filepath_out}")
  add_custom_command(
    TARGET ${_target}
    PRE_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy ${_filepath_in} ${_filepath_out}
  )
endmacro(copy_file_before_build)

macro(copy_dir_before_build _target _dirpath_in _dirpath_out)
  addon_debug("TARGET ${_target} COPY DIR FROM ${_dirpath_in} TO ${_dirpath_out}")
  add_custom_command(
    TARGET ${_target}
    PRE_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_directory ${_dirpath_in} ${_dirpath_out}
  )
endmacro(copy_dir_before_build)

macro(get_parent_dirname _dirname)
  get_filename_component(${_dirname} ${CMAKE_CURRENT_SOURCE_DIR} NAME_WLE)
endmacro()

macro(get_last_dirname _path _dirname)
  get_filename_component(${_dirname} ${_path} NAME_WLE)
endmacro()

function(get_all_targets var)
  set(targets)
  get_all_targets_recursive(targets ${CMAKE_CURRENT_SOURCE_DIR})
  set(${var} ${targets} PARENT_SCOPE)
endfunction()

macro(get_all_targets_recursive targets dir)
  get_property(subdirectories DIRECTORY ${dir} PROPERTY SUBDIRECTORIES)
  foreach(subdir ${subdirectories})
    get_all_targets_recursive(${targets} ${subdir})
  endforeach()

  get_property(current_targets DIRECTORY ${dir} PROPERTY BUILDSYSTEM_TARGETS)
  list(APPEND ${targets} ${current_targets})
endmacro()
