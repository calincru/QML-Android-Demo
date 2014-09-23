## Sources

This directory will contain all source files. When writing **QML** apps, by
source files we refer to **.qml**'s, **.cpp**'s and **.qrc**'s. While the first
two extensions may speak for themselves, the third one may be less known.

When writing **Qt** applications in general, you often need *resource files*,
such as images, sound files, fonts, etc. To include these resource files within
app's executable, you have to declare them in a .qrc file. Qt has a mechanism to
generate .cpp files associated to each .qrc file, but to do that, you need to
specify the resource files (see the `qt5_add_resources(..)` in *CMakeLists.txt*).

Qml files are also considered resource files. That is why you will find within
this trivial example's .qrc file only the .qml file.
