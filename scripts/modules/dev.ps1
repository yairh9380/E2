# Development Environment Configuration Module

# Import utility functions
. "$PSScriptRoot\..\utils\logging.ps1"

function Configure-VSCode {
    Write-Log "Configuring Visual Studio Code..."
    
    $vsCodeDir = "$env:APPDATA\Code\User"
    if (!(Test-Path $vsCodeDir)) {
        New-Item -ItemType Directory -Path $vsCodeDir -Force | Out-Null
    }
    
    # Copy VS Code settings
    Copy-Item "$PSScriptRoot\..\..\config\vscode\settings.json" "$vsCodeDir\settings.json" -Force
    
    # Install VS Code extensions
    $extensions = Get-Content "$PSScriptRoot\..\..\config\vscode\extensions.list"
    foreach ($extension in $extensions) {
        if ($extension -and !$extension.StartsWith("#")) {
            Write-Log "Installing VS Code extension: $extension..."
            code --install-extension $extension
        }
    }
}

function Configure-Git {
    Write-Log "Configuring Git..."
    
    # Configure global Git settings
    git config --global core.autocrlf true
    git config --global init.defaultBranch main
    
    Write-Log "Git configuration completed successfully" -Level Info
}

# Execute configuration
Configure-VSCode
Configure-Git