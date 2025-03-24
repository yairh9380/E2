# Terminal Configuration Module

# Import utility functions
. "$PSScriptRoot\..\utils\logging.ps1"

function Install-OhMyPosh {
    Write-Log "Installing Oh My Posh..."
    
    # Install Oh My Posh via winget
    winget install JanDeDobbeleer.OhMyPosh -s winget
    
    # Create Oh My Posh configuration directory if it doesn't exist
    $configDir = "$env:USERPROFILE\.config\oh-my-posh"
    if (!(Test-Path $configDir)) {
        New-Item -ItemType Directory -Path $configDir -Force | Out-Null
    }
    
    # Copy theme file
    Copy-Item "$PSScriptRoot\..\..\config\terminal\oh-my-posh\theme.omp.json" "$configDir\theme.omp.json" -Force
}

function Configure-WindowsTerminal {
    Write-Log "Configuring Windows Terminal..."
    
    $terminalConfigDir = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"
    if (!(Test-Path $terminalConfigDir)) {
        New-Item -ItemType Directory -Path $terminalConfigDir -Force | Out-Null
    }
    
    # Copy terminal settings
    Copy-Item "$PSScriptRoot\..\..\config\terminal\settings.json" "$terminalConfigDir\settings.json" -Force
}

function Configure-PowerShellProfile {
    Write-Log "Configuring PowerShell profile..."
    
    $profileDir = Split-Path $PROFILE
    if (!(Test-Path $profileDir)) {
        New-Item -ItemType Directory -Path $profileDir -Force | Out-Null
    }
    
    # Copy PowerShell profile
    Copy-Item "$PSScriptRoot\..\..\config\powershell\Microsoft.PowerShell_profile.ps1" $PROFILE -Force
}

# Execute configuration
Install-OhMyPosh
Configure-WindowsTerminal
Configure-PowerShellProfile