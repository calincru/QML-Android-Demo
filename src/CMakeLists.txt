set(demo_SRCS demo.cpp)
qt5_add_resources(demo_QRC demo.qrc)

if (ANDROID)
  add_library(Demo SHARED ${demo_SRCS} ${demo_QRC})
  qt5_use_modules(Demo Qml Quick)
else()
  add_executable(Demo ${demo_SRCS} ${demo_QRC})
  qt5_use_modules(Demo Qml Quick)
endif()

target_link_libraries(Demo Qt5::Qml Qt5::Quick)
