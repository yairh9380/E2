# Package Management Module

# Import utility functions
. "$PSScriptRoot\..\utils\logging.ps1"

function Install-Chocolatey {
    Write-Log "Installing Chocolatey package manager..."
    
    if (!(Get-Command choco -ErrorAction SilentlyContinue)) {
        Set-ExecutionPolicy Bypass -Scope Process -Force
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    } else {
        Write-Log "Chocolatey is already installed" -Level Info
    }
}

function Install-BasePackages {
    Write-Log "Installing base packages..."
    
    $basePackages = Get-Content "$PSScriptRoot\..\..\packages\base.txt"
    foreach ($package in $basePackages) {
        if ($package -and !$package.StartsWith("#")) {
            Write-Log "Installing $package..."
            choco install $package -y
        }
    }
}

function Install-DevPackages {
    Write-Log "Installing development packages..."
    
    $devPackages = Get-Content "$PSScriptRoot\..\..\packages\dev.txt"
    foreach ($package in $devPackages) {
        if ($package -and !$package.StartsWith("#")) {
            Write-Log "Installing $package..."
            choco install $package -y
        }
    }
}

# Execute package installation
Install-Chocolatey
Install-BasePackages
Install-DevPackages