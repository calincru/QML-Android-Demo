set( demo_SRCS demo.cpp )

if( ANDROID )
  add_library( Demo SHARED ${demo_SRCS} )
  qt5_use_modules( Demo Qml Quick )
else()
  add_executable( Demo ${demo_SRCS} )
  qt5_use_modules( Demo Qml Quick )
endif()

target_link_libraries( Demo Qt5::Qml Qt5::Quick )

DEMO_ADD_RCC(src Demo.qml)
