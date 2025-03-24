# VS Code Configuration Module

# Import utility functions
. "$PSScriptRoot\..\utils\logging.ps1"

function Install-VSCodeExtensions {
    Write-Log "Installing VS Code extensions..."
    
    # Check if VS Code is installed
    if (!(Get-Command code -ErrorAction SilentlyContinue)) {
        Write-Log "VS Code is not installed. Installing VS Code..." -Level Warning
        winget install Microsoft.VisualStudioCode -s winget --accept-source-agreements --accept-package-agreements
        
        # Wait for VS Code to be available in PATH
        $retries = 0
        while (!(Get-Command code -ErrorAction SilentlyContinue) -and $retries -lt 5) {
            Start-Sleep -Seconds 2
            $retries++
            $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
        }
        
        if (!(Get-Command code -ErrorAction SilentlyContinue)) {
            Write-Log "VS Code installation failed or PATH not updated. Please restart your terminal and try again." -Level Error
            return
        }
    }
    
    # Read and install extensions from the list
    $extensionsFile = "$PSScriptRoot\..\..\config\vscode\extensions.list"
    if (Test-Path $extensionsFile) {
        $extensions = Get-Content $extensionsFile
        foreach ($line in $extensions) {
            $extension = $line.Trim()
            if ($extension -and !$extension.StartsWith("#")) {
                Write-Log "Installing extension: $extension"
                try {
                    $result = code --install-extension $extension 2>&1
                    if ($LASTEXITCODE -eq 0) {
                        Write-Log "Successfully installed: $extension" -Level Info
                    } else {
                        Write-Log "Failed to install extension: $extension. Error: $result" -Level Warning
                    }
                } catch {
                    Write-Log "Error installing extension $extension: $_" -Level Error
                }
            }
        }
        Write-Log "VS Code extensions installation completed" -Level Info
    } else {
        Write-Log "Extensions file not found at: $extensionsFile" -Level Error
    }
}

function Configure-VSCode {
    Write-Log "Configuring VS Code settings..."
    
    $vsCodeDir = "$env:APPDATA\Code\User"
    if (!(Test-Path $vsCodeDir)) {
        New-Item -ItemType Directory -Path $vsCodeDir -Force | Out-Null
    }
    
    # Copy VS Code settings
    $settingsFile = "$PSScriptRoot\..\..\config\vscode\settings.json"
    if (Test-Path $settingsFile) {
        Copy-Item $settingsFile "$vsCodeDir\settings.json" -Force
        Write-Log "VS Code settings applied successfully"
    } else {
        Write-Log "Settings file not found at: $settingsFile" -Level Error
    }
}

# Execute configuration
Install-VSCodeExtensions
Configure-VSCode