<img src="resources/Animatica_logo.png" alt="Animatica" width="500"/>

[![C++](https://img.shields.io/badge/language-C++-blue.svg)](#)
[![build system: CMake](https://img.shields.io/static/v1?color=blue&label=build%20system&logo=cmake&message=CMake)](#)
![UIkit: wxWidgets](https://img.shields.io/static/v1?label=UI%20toolkit&message=wxWidgets&color=green&logo=wxwidgets&logoColor=white&style=flat-square)
![Supported Platform – macOS](https://img.shields.io/badge/Supported%20Platform-macOS-blue?logo=apple&logoColor=white&style=flat)
 

## About the project

Animatica is an animation program that plays GIF animations on top of other windows.

The mechanics of this program are interestingly constructed:
The events of opening and closing the application were rewritten to an animation step forward or backward.

### Steps

```bash
# 1. Clone repository
git clone https://github.com/DiCode77/Animatica.git --recurse-submodules
cd Animatica;

# 2. Install Vcpkg dependencies
./vcpkg/bootstrap-vcpkg.sh;
./vcpkg/vcpkg install;

# 3. Create a directory for the build
mkdir build && cd build;

# 4. Configure the configuration via CMake
cmake .. -G "Xcode"

# 5. Assemble the project
xcodebuild -configuration Release