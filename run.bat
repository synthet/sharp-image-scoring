@echo off
setlocal
cd /d "%~dp0"

echo.
echo ===========================================
echo   Sharp Image Scoring - Gallery Viewer
echo ===========================================
echo.

REM Check if dotnet is installed
where dotnet >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo [ERROR] .NET SDK not found.
    echo Please install .NET 8.0 SDK from https://dotnet.microsoft.com/download
    pause
    exit /b 1
)

echo Starting the WPF Application...
dotnet run --project ImageGalleryViewer\ImageGalleryViewer.csproj --configuration Debug

if %ERRORLEVEL% neq 0 (
    echo.
    echo [ERROR] Application failed to start.
    pause
    exit /b %ERRORLEVEL%
)

endlocal
