macro(get_parent_dirname _dirname)
    get_filename_component(${_dirname} ${CMAKE_CURRENT_SOURCE_DIR} NAME_WLE)
endmacro()

macro(get_last_dirname _path _dirname)
    get_filename_component(${_dirname} ${_path} NAME_WLE)
endmacro()
