@echo off
title DirectX DLL Cleanup Tool

::----------------------------
:: Check admin privileges
::----------------------------
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] This script must be run as Administrator!
    echo Right-click and choose "Run as administrator".
    pause
    exit /b 1
)

echo [INFO] Running with Administrator rights...
echo.

::----------------------------
:: Delete from System32
::----------------------------
echo [INFO] Cleaning %%WINDIR%%\System32
pushd %windir%\system32
call :delete
popd

::----------------------------
:: Delete from SysWOW64 (64-bit only)
::----------------------------
if exist %windir%\syswow64\nul (
    if "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
        echo.
        echo [INFO] Cleaning %%WINDIR%%\SysWOW64
        pushd %windir%\syswow64
        call :delete
        popd
    )
)

echo.
echo [DONE] Cleanup complete. 
echo You need to reinstall the DirectX End-User Runtime afterwards.
pause
exit /b 0

::----------------------------
:: Subroutine: Delete DLLs
::----------------------------
:delete
for %%F in (
    d3dcompiler_33.dll d3dcompiler_34.dll d3dcompiler_35.dll d3dcompiler_36.dll
    D3DCompiler_37.dll D3DCompiler_38.dll D3DCompiler_39.dll D3DCompiler_40.dll
    D3DCompiler_41.dll D3DCompiler_42.dll D3DCompiler_43.dll
    d3dcsx_42.dll d3dcsx_43.dll
    d3dx9_24.dll d3dx9_25.dll d3dx9_26.dll d3dx9_27.dll d3dx9_28.dll
    d3dx9_29.dll d3dx9_30.dll d3dx9_31.dll d3dx9_32.dll d3dx9_33.dll
    d3dx9_34.dll d3dx9_35.dll d3dx9_36.dll d3dx9_37.dll d3dx9_38.dll
    d3dx9_39.dll d3dx9_40.dll d3dx9_41.dll d3dx9_42.dll d3dx9_43.dll
    d3dx10.dll d3dx10_33.dll d3dx10_34.dll d3dx10_35.dll d3dx10_36.dll
    d3dx10_37.dll d3dx10_38.dll d3dx10_39.dll d3dx10_40.dll d3dx10_41.dll
    d3dx10_42.dll d3dx10_43.dll d3dx11_42.dll d3dx11_43.dll
    x3daudio1_0.dll x3daudio1_1.dll x3daudio1_2.dll X3DAudio1_3.dll
    X3DAudio1_4.dll X3DAudio1_5.dll X3DAudio1_6.dll X3DAudio1_7.dll
    xactengine2_0.dll xactengine2_1.dll xactengine2_2.dll xactengine2_3.dll
    xactengine2_4.dll xactengine2_5.dll xactengine2_6.dll xactengine2_7.dll
    xactengine2_8.dll xactengine2_9.dll xactengine2_10.dll
    xactengine3_0.dll xactengine3_1.dll xactengine3_2.dll xactengine3_3.dll
    xactengine3_4.dll xactengine3_5.dll xactengine3_6.dll xactengine3_7.dll
    XAPOFX1_0.dll XAPOFX1_1.dll XAPOFX1_2.dll XAPOFX1_3.dll XAPOFX1_4.dll XAPOFX1_5.dll
    XAudio2_0.dll XAudio2_1.dll XAudio2_2.dll XAudio2_3.dll XAudio2_4.dll
    XAudio2_5.dll XAudio2_6.dll XAudio2_7.dll
    xinput1_1.dll xinput1_2.dll xinput1_3.dll
) do (
    if exist "%%F" (
        del /q "%%F"
        if exist "%%F" (
            echo [FAIL] %%F
        ) else (
            echo [OK]   %%F
        )
    ) else (
        echo [SKIP] %%F (not found^)
    )
)
exit /b
