## Platforms

This subdirectory contains **toolchain files**. These files need to be modified
only when developing an application for a some specific android platform or ABI.

**Note:** this directory **must** be named like this. This is because the
**androiddeployqt** tool assumes so (for more about this tool, check the
project's *tool* subdirectory). If you **really** need to use a different
name, you must change this tool's source file.
