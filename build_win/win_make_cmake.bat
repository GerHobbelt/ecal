@echo off

pushd "%~dp0\.."

call build_win\win_set_vars.bat

echo Downloading NPCAP
powershell -Command "& '%~dp0\download_npcap.ps1'"

set CMAKE_OPTIONS_COMPLETE=-DCMAKE_INSTALL_PREFIX=_install ^
-DHAS_HDF5=ON ^
-DHAS_QT5=ON ^
-DHAS_CURL=ON ^
-DHAS_CAPNPROTO=OFF ^
-DHAS_FTXUI=ON ^
-DBUILD_DOCS=ON ^
-DBUILD_APPS=ON ^
-DBUILD_SAMPLES=ON ^
-DBUILD_TIME=ON ^
-DBUILD_PY_BINDING=ON ^
-DBUILD_CSHARP_BINDING=ON ^
-DBUILD_ECAL_TESTS=ON ^
-DECAL_INCLUDE_PY_SAMPLES=OFF ^
-DECAL_INSTALL_SAMPLE_SOURCES=ON ^
-DECAL_JOIN_MULTICAST_TWICE=OFF ^
-DECAL_NPCAP_SUPPORT=ON ^
-DECAL_THIRDPARTY_BUILD_CMAKE_FUNCTIONS=ON ^
-DECAL_THIRDPARTY_BUILD_PROTOBUF=ON ^
-DECAL_THIRDPARTY_BUILD_SPDLOG=ON ^
-DECAL_THIRDPARTY_BUILD_TINYXML2=ON ^
-DECAL_THIRDPARTY_BUILD_FINEFTP=ON ^
-DECAL_THIRDPARTY_BUILD_CURL=ON ^
-DECAL_THIRDPARTY_BUILD_GTEST=ON ^
-DECAL_THIRDPARTY_BUILD_HDF5=ON ^
-DECAL_THIRDPARTY_BUILD_RECYCLE=ON ^
-DECAL_THIRDPARTY_BUILD_TCP_PUBSUB=ON ^
-DECAL_THIRDPARTY_BUILD_QWT=ON ^
-DECAL_THIRDPARTY_BUILD_YAML-CPP=ON ^
-DECAL_THIRDPARTY_BUILD_UDPCAP=ON ^
-DBUILD_SHARED_LIBS=OFF ^
-DCMAKE_BUILD_TYPE=Release ^
-DCPACK_PACK_WITH_INNOSETUP=ON

set CMAKE_OPTIONS_SDK=-DCMAKE_INSTALL_PREFIX=_install ^
-DHAS_HDF5=ON ^
-DHAS_QT5=ON ^
-DHAS_CURL=OFF ^
-DHAS_CAPNPROTO=OFF ^
-DHAS_FTXUI=ON ^
-DBUILD_DOCS=OFF ^
-DBUILD_APPS=OFF ^
-DBUILD_SAMPLES=OFF ^
-DBUILD_TIME=ON ^
-DBUILD_PY_BINDING=OFF ^
-DBUILD_CSHARP_BINDING=OFF ^
-DBUILD_ECAL_TESTS=OFF ^
-DECAL_INCLUDE_PY_SAMPLES=OFF ^
-DECAL_INSTALL_SAMPLE_SOURCES=OFF ^
-DECAL_JOIN_MULTICAST_TWICE=OFF ^
-DECAL_NPCAP_SUPPORT=ON ^
-DECAL_THIRDPARTY_BUILD_CMAKE_FUNCTIONS=ON ^
-DECAL_THIRDPARTY_BUILD_PROTOBUF=ON ^
-DECAL_THIRDPARTY_BUILD_SPDLOG=ON ^
-DECAL_THIRDPARTY_BUILD_TINYXML2=ON ^
-DECAL_THIRDPARTY_BUILD_FINEFTP=OFF ^
-DECAL_THIRDPARTY_BUILD_CURL=OFF ^
-DECAL_THIRDPARTY_BUILD_GTEST=OFF ^
-DECAL_THIRDPARTY_BUILD_HDF5=ON ^
-DECAL_THIRDPARTY_BUILD_RECYCLE=ON ^
-DECAL_THIRDPARTY_BUILD_TCP_PUBSUB=ON ^
-DECAL_THIRDPARTY_BUILD_QWT=OFF ^
-DECAL_THIRDPARTY_BUILD_YAML-CPP=OFF ^
-DECAL_THIRDPARTY_BUILD_UDPCAP=ON ^
-DBUILD_SHARED_LIBS=OFF ^
-DCMAKE_BUILD_TYPE=Debug ^
-DCPACK_PACK_WITH_INNOSETUP=OFF

if not exist "%BUILD_DIR_COMPLETE%" mkdir "%BUILD_DIR_COMPLETE%"
if not exist "%BUILD_DIR_SDK%" mkdir "%BUILD_DIR_SDK%"

echo Creating Python venv
if not exist "%BUILD_DIR_COMPLETE%\.venv" mkdir "%BUILD_DIR_COMPLETE%\.venv"
python -m venv "%BUILD_DIR_COMPLETE%\.venv"
CALL "%BUILD_DIR_COMPLETE%\.venv\Scripts\activate.bat"

echo Upgrading pip
python -m pip install --upgrade pip

echo Installing python requirements
pip install wheel
pip install -r doc\requirements.txt

cd /d "%WORKSPACE%\%BUILD_DIR_COMPLETE%"
cmake ../.. -A x64 %CMAKE_OPTIONS_COMPLETE% %*

cd /d "%WORKSPACE%\%BUILD_DIR_SDK%"
cmake ../.. -A x64 %CMAKE_OPTIONS_SDK% %*

popd
