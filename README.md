# QML for Android Demo

This is just a *Hello World* application, I (Calin Cruceru) wrote in **QML**
and configured with **CMake**, to allow deploying on different 
OSs/architectures: Android, Linux, Windows, MacOS (adding *iOS* support would
only imply copying the toolchain file from
[here](https://code.google.com/p/ios-cmake/), but since I couldn't test it, I
skipped this step).

What is nice about such a trivial application is that it is a good example for
those who want to develop cross-platform QML applications using CMake (there
are few such examples out there).


## Directory structure

- **android** - files needed by any android application. Similar dirs should
be added for each platform (e.g. iOS);
- **platforms** - toolchain files specific to each platform and loaded by CMake
when cross-compiling. For more details about toolchain files check out
[CMake's documentation](http://www.cmake.org/Wiki/CMake_Cross_Compiling);
- **src** - all project's source files;

Each directory contains its on *README* file, so press each one for more
details.


## Configuration

Before getting the application working, a couple of dependencies must be
solved.

First, you will need [Android SDK](http://developer.android.com/sdk/index.html)
and [Android NDK](http://developer.android.com/tools/sdk/ndk/index.html). Make
sure you download the latest versions. Also, you will need
[ant](http://ant.apache.org/). Add all these to your *PATH*.

Then, you will need **Qt5** installed for both your host machine and for
android/ios if you are planning to deploy the application on these
OSs. These two links should guide you to do that:
- [Build Qt5 from sources](http://qt-project.org/wiki/Building_Qt_5_from_Git)
- [Build Qt5 for Android](http://qt-project.org/wiki/Qt5ForAndroidBuilding)

Make sure to add the installation dir for each to your *PATH*. Then, add these
exports to your **.bashrc/.zshrc** and you should be all set up:
```bash
export JAVA_HOME=<path to your jdk root dir>
export ANDROID_HOME=<path to your android-sdk dir>
export ANDROID_SDK=<path to your android-sdk dir>
export ANDROID_NDK=<path to your android-ndk dir>
export ANDROID_NDK_TOOLCHAIN_ROOT=<path to your android-ndk/toolchains dir>

export Qt5_host=<path to your host Qt5  installation dir>
export Qt5_android=<path to yout android Qt5 installation dir>
```

Alternatively, if you are on ArchLinux, install Qt5 from the [official
repos](https://www.archlinux.org/groups/x86_64/qt5/) and install
**android-qt5-armeabiv7a** [from
AUR](https://aur.archlinux.org/packages/android-qt5-armeabi-v7a/).  It will
install all its dependencies, including Android SDK/NDK.

These are my exports after installing the above mentioned packages:
```bash
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk
export ANDROID_HOME=/opt/android-sdk
export ANDROID_SDK=/opt/android-sdk
export ANDROID_NDK=/opt/android-ndk
export ANDROID_NDK_TOOLCHAIN_ROOT=/opt/android-ndk/toolchains
export Qt5_host=/usr
export Qt5_android=/opt/android-qt5/5.5.1/armeabi-v7a

export PATH="/opt/android-sdk/tools:$PATH"
export PATH="/opt/android-qt5/5.5.1/armeabi-v7a/bin:$PATH"
```

## Install

Installation depends on whether you want to get the application working on
your own machine or some external device (Android devices are the only
option in this example).

To generate the executable for your **own machine** (be it a
Linux/Windows/MacOS):

```bash
cd ~
git clone https://github.com/calincru/QML-Android-Demo
mkdir QML-Android-Demo/build
cd QML-Android-Demo/build
cmake ..
make
```

I used **bash** syntax, but it's easy to adapt it to other shells.
It should create an executable named **Demo** in `~/QML-Android-Demo/build/bin`.


To generate the **.apk** file for an Android device:

```bash
cd ~
git clone https://github.com/calincru/QML-Android-Demo
mkdir QML-Android-Demo/build
cd QML-Android-Demo/build
cmake .. -DCMAKE_TOOLCHAIN_FILE=../platforms/android.cmake -Wno-dev
make
make apk_debug
```

It should create a **.apk** file in `~/QML-Android-Demo/build/android/bin`.
To deploy it to your Android mobile phone, simply connect it to your PC via
USB and type in your console
`adb install -r ~/QML-Android-Demo/build/android/bin/<name_of_the_apk_file>`.
