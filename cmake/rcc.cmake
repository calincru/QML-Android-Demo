# DEMO_ADD_RCC is a function used to add resource files without manually
# creating the .qrc files.
#
# USAGE:
#   DEMO_ADD_RCC(path/relative/to/top/root <list_of_resource_files>)
#
# Note that globbing expresions can be used.
# Example:
#   DEMO_ADD_RCC(src/core *.qml *.svg *.js resources/*)
function(DEMO_ADD_RCC resource_path)

  set( options )
  set( oneValueArgs )
  set( multiValueArgs )
  cmake_parse_arguments( _RCC "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN} )
  set( rcc_files ${_RCC_UNPARSED_ARGUMENTS} )

  get_filename_component( activity "${resource_path}" NAME )

  # Create this QRC file
  # Must create it in the source dir because rcc expects local files
  set( CREATED_QRC "${CMAKE_CURRENT_SOURCE_DIR}/${activity}.qrc" )

  set( ACTIVITY_PATH "/Demo/${resource_path}" )
  file( GLOB QRC_CONTENTS RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} ${rcc_files} )
  file( GLOB QRC_CONTENTS_ABS ${CMAKE_CURRENT_SOURCE_DIR} ${rcc_files} )

  file( WRITE ${CREATED_QRC} "<RCC>\n\t<qresource prefix=\"${ACTIVITY_PATH}\">" )
  foreach( FILE ${QRC_CONTENTS} )
    file( APPEND ${CREATED_QRC} "\n\t\t<file>${FILE}</file>" )
  endforeach()
  file( APPEND ${CREATED_QRC} "\n\t</qresource>\n</RCC>\n" )
  list( APPEND QRC_FILES ${CREATED_QRC} )

  set( CREATED_RCC ${DEMO_RCC_DIR}/${activity}.rcc )

  add_custom_command(
    OUTPUT ${CREATED_RCC}
    COMMAND cmake -E make_directory ${DEMO_RCC_DIR}
    COMMAND ${Qt5Core_RCC_EXECUTABLE} "-binary" -o ${CREATED_RCC} ${CREATED_QRC}
    DEPENDS ${QRC_CONTENTS} "${out_depends}" VERBATIM
  )
  install(FILES ${CREATED_RCC} DESTINATION bin/rcc)

  add_custom_target(
    rcc_${activity} ALL
    DEPENDS ${CREATED_RCC} ${CREATED_QRC}
    COMMENT "Generate ${activity} RCC"
    SOURCES ${QRC_CONTENTS}
    VERBATIM
  )

endfunction()
