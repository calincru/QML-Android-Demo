## Android

This subdir will usually contain the following:

- **CMakeLists.txt** - CMake configuration file which sets the targets for
building the **.apk** file to be deployed on Android devices or to
**Google Play**. This is where the **androiddeployqt** tool is being called.
To find more about it, check out the project's *tool* subdirectory.
This file does not usually need to be changed.

- **AndroidManifest.xml.cmake** - each android application should provide an
AndroidManifest.xml file. To read more about it, the
[Android's documentation](http://developer.android.com/guide/topics/manifest/manifest-intro.html)
is pretty rich in details. What is interesting about our manifest file is that
it is in some sort of *template* form as you may notice, as it will be
processed by the **androiddeployqt** tool. In fact, both CMake and
androiddeployqt tool will modify this file. First, CMake will replace
everything like **@SOMEVARIABLE@** with its value, so CMake **should** know
that value. It will also remove the .cmake extension and copy the file in the
build directory. Then androiddeployqt tool will generate a regular
AndroidManifest.xml file by replacing **"-- %% VARIABLE %% --"** with that
variable's value (usually those are paths, version codes, etc).

- **configAndroid.json.cmake** - as its name says, this is a configuration file
which is to be read by the **androiddeployqt**. Similar to the manifest file,
CMake will generate a *configAndroid.json* file within the build directory. It
will also interpret this syntax: **@VAR@** like: *VAR is a variable and I should
replace it with its actual value*.

- **res** directory - contains usually an icon for different resolutions
(which are required when uploading the app to store, for example) and other
resources.
