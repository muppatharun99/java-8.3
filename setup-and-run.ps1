$ErrorActionPreference = "Stop"

$javafxVersion = "22.0.1"
$javafxDir = "javafx-sdk-$javafxVersion"

# Check if JavaFX SDK already exists
if (-not (Test-Path $javafxDir)) {
    Write-Host "Downloading JavaFX SDK $javafxVersion..." -ForegroundColor Cyan
    
    # Try direct download with multiple mirrors
    $downloadUrl = "https://download2.gluonhq.com/openjfx/22.0.1/openjfx-22.0.1_windows-x64_bin-sdk.zip"
    
    try {
        Invoke-WebRequest -Uri $downloadUrl -OutFile "javafx-sdk.zip" -ErrorAction Stop
        Write-Host "Downloaded successfully. Extracting..." -ForegroundColor Green
        
        Add-Type -AssemblyName System.IO.Compression.FileSystem
        [System.IO.Compression.ZipFile]::ExtractToDirectory("javafx-sdk.zip", ".")
        
        # Rename the extracted folder
        if (Test-Path "openjfx-22.0.1_windows-x64_bin-sdk") {
            Rename-Item -Path "openjfx-22.0.1_windows-x64_bin-sdk" -NewName $javafxDir
        }
        
        Remove-Item "javafx-sdk.zip"
        Write-Host "JavaFX SDK extracted successfully!" -ForegroundColor Green
    }
    catch {
        Write-Host "Download failed. Please download manually:" -ForegroundColor Red
        Write-Host "https://gluonhq.com/products/javafx/" -ForegroundColor Yellow
        exit 1
    }
}
else {
    Write-Host "JavaFX SDK already present." -ForegroundColor Green
}

# Set JavaFX classpath
$javafxLib = (Get-Item $javafxDir).FullName + "\lib"
$modulePath = "--module-path $javafxLib --add-modules javafx.controls,javafx.fxml"

# Compile
Write-Host "`nCompiling TipCalculator.java..." -ForegroundColor Cyan
$compileCmd = "javac $modulePath TipCalculator.java"
Invoke-Expression $compileCmd

if ($LASTEXITCODE -ne 0) {
    Write-Host "Compilation failed!" -ForegroundColor Red
    exit 1
}

Write-Host "Compilation successful!" -ForegroundColor Green

# Run
Write-Host "`nRunning TipCalculator..." -ForegroundColor Cyan
$runCmd = "java $modulePath TipCalculator"
Invoke-Expression $runCmd
