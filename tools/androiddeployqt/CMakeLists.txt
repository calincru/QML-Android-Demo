set(DEMO_ANDROIDDEPLOYQT_DIR ${DEMO_TOOLS_BINARY_DIR}/androiddeployqt CACHE STRING "androiddeployqt tool's binary directory" FORCE)
message(STATUS "The androiddeployqt tool's directory is ${DEMO_ANDROIDDEPLOYQT_DIR}")

file(COPY ${CMAKE_CURRENT_SOURCE_DIR} DESTINATION ${DEMO_TOOLS_BINARY_DIR})
