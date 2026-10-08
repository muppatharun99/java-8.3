@echo off
REM Tip Calculator Build and Run Script

echo Downloading JavaFX SDK...
if not exist "javafx-sdk-22.0.1" (
    powershell -Command "Invoke-WebRequest -Uri 'https://gluonhq.com/download/javafx-22-0-1-sdk-windows/' -OutFile javafx-sdk.zip 2>nul; if ($?) { Add-Type -AssemblyName System.IO.Compression.FileSystem; [System.IO.Compression.ZipFile]::ExtractToDirectory('javafx-sdk.zip', '.'); Remove-Item javafx-sdk.zip }" 2>nul
    if errorlevel 1 (
        echo Failed to download JavaFX automatically.
        echo Please download JavaFX SDK from: https://gluonhq.com/products/javafx/
        echo And extract it to this folder as 'javafx-sdk-22.0.1'
        pause
        exit /b 1
    )
)

set JAVAFX_HOME=%CD%\javafx-sdk-22.0.1
set PATH_TO_FX=%JAVAFX_HOME%\lib

echo Compiling TipCalculator.java...
javac --module-path %PATH_TO_FX% --add-modules javafx.controls,javafx.fxml TipCalculator.java
if errorlevel 1 (
    echo Compilation failed!
    pause
    exit /b 1
)

echo Running TipCalculator...
java --module-path %PATH_TO_FX% --add-modules javafx.controls,javafx.fxml TipCalculator
pause
