@echo off
REM Maven Wrapper script for Windows

setlocal enabledelayedexpansion

set MAVEN_VERSION=3.9.0
set MAVEN_HOME=%~dp0.mvn\maven-%MAVEN_VERSION%

if not exist "%MAVEN_HOME%" (
    echo Downloading Maven %MAVEN_VERSION%...
    if not exist "%~dp0.mvn" mkdir "%~dp0.mvn"
    
    REM Download Maven
    powershell -Command "& {$ProgressPreference = 'SilentlyContinue'; Invoke-WebRequest -Uri 'https://archive.apache.org/dist/maven/maven-3/%MAVEN_VERSION%/binaries/apache-maven-%MAVEN_VERSION%-bin.zip' -OutFile '%~dp0.mvn\maven.zip'; [System.IO.Compression.ZipFile]::ExtractToDirectory('%~dp0.mvn\maven.zip', '%~dp0.mvn'); Remove-Item '%~dp0.mvn\maven.zip'}"
)

set PATH=%MAVEN_HOME%\bin;%PATH%

call mvn %*
