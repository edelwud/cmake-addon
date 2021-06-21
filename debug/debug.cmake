macro(addon_debug _msg_string)
  if(CMAKE_ADDON_DEBUG)
    message("ADDON DEBUG: " ${_msg_string})
  endif()
endmacro(addon_debug)

macro(set_addon_debug)
  set(CMAKE_ADDON_DEBUG ON)
endmacro(set_addon_debug)

macro(unset_addon_debug)
  set(CMAKE_ADDON_DEBUG OFF)
endmacro(unset_addon_debug)
