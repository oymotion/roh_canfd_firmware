@echo off
setlocal enabledelayedexpansion

REM -------- 1. 定义关键路径 --------
REM 你的 MSVC 编译器版本的 Qt 路径（请修改为你的实际路径）
set QT_MSVC_PATH=D:\Programs\Qt\6.11.0\msvc2022_64

REM 你的发布目录（编译生成的 exe 所在目录）
set DEPLOY_DIR=D:\work\oymotion\ROHandSetting\build\release

REM -------- 2. 切换到发布目录 --------
cd /d "%DEPLOY_DIR%"

REM -------- 3. 确保版本匹配，执行 windeployqt --------
echo [1/2] Deploying Qt libraries with MSVC windeployqt...
"%QT_MSVC_PATH%\bin\windeployqt.exe" OHandSetting.exe

REM -------- 4. 手动复制第三方依赖（PCAN/ZLG） --------
echo [2/2] Copying third-party dependencies...

REM 如果使用 PCAN
set PCAN_DLL=D:\Programs\PEAK-System\PCAN-Basic\x64\PCANBasic.dll
if exist "%PCAN_DLL%" (
    copy /Y "%PCAN_DLL%" .\
) else (
    echo Warning: PCANBasic.dll not found at %PCAN_DLL%
)

REM 如果使用 ZLG（根据你的 CMake 配置）
set ZLG_DLL=.\src\deps\zlg_can\bin\ControlCANFD.dll
if exist "%ZLG_DLL%" (
    copy /Y "%ZLG_DLL%" .\
) else (
    echo Warning: ControlCANFD.dll not found at %ZLG_DLL%
)

echo Deploy completed!
pause