# Menu System Module

function Show-MainMenu {
    Clear-Host
    Write-Host "=== ElCapulin Windows Configuration Menu ===`n"
    Write-Host "1. Run Installation Script"
    Write-Host "2. Development Tools"
    Write-Host "3. Windows Activation"
    Write-Host "0. Exit"
    
    $choice = Read-Host "`nEnter your choice"
    
    switch ($choice) {
        "1" {
            Install-BaseApplications
            Install-OptimizationModules
        }
        "2" { Show-DevelopmentMenu }
        "3" { 
            . "$PSScriptRoot\activation_menu.ps1"
            Show-ActivationMenu 
        }
        "0" { exit }
        default { 
            Write-Host "Invalid choice. Press any key to continue..."
            $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
            Show-MainMenu
        }
    }
}

function Show-DevelopmentMenu {
    Clear-Host
    Write-Host "=== Development Tools Menu ===`n"
    Write-Host "1. Install WSL2 and Linux Distribution"
    Write-Host "2. Install Docker Development Environment"
    Write-Host "3. Install Node.js Development Stack"
    Write-Host "4. Install Python Development Environment"
    Write-Host "5. Install Git and Version Control Tools"
    Write-Host "0. Back to Main Menu"
    
    $choice = Read-Host "`nEnter your choice"
    
    switch ($choice) {
        "1" { Install-WSL2Environment }
        "2" { Install-DockerEnvironment }
        "3" { Install-NodeEnvironment }
        "4" { Install-PythonEnvironment }
        "5" { Install-GitTools }
        "0" { Show-MainMenu }
        default {
            Write-Host "Invalid choice. Press any key to continue..."
            $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
            Show-DevelopmentMenu
        }
    }
}

function Install-WSL2Environment {
    Write-Host "Installing WSL2 and enabling required features..."
    
    # Enable Windows Features
    Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -NoRestart
    Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform -NoRestart
    
    # Set WSL2 as default
    wsl --set-default-version 2
    
    # Install Ubuntu (can be customized based on preference)
    winget install Canonical.Ubuntu.2204 -s winget --accept-source-agreements --accept-package-agreements
    
    Write-Host "WSL2 installation completed. Press any key to continue..."
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
    Show-DevelopmentMenu
}

function Install-DockerEnvironment {
    Write-Host "Installing Docker Desktop..."
    winget install Docker.DockerDesktop -s winget --accept-source-agreements --accept-package-agreements
    Write-Host "Docker installation completed. Press any key to continue..."
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
    Show-DevelopmentMenu
}

function Install-NodeEnvironment {
    Write-Host "Installing Node.js and development tools..."
    winget install OpenJS.NodeJS.LTS -s winget --accept-source-agreements --accept-package-agreements
    Write-Host "Node.js installation completed. Press any key to continue..."
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
    Show-DevelopmentMenu
}

function Install-PythonEnvironment {
    Write-Host "Installing Python and development tools..."
    winget install Python.Python.3.11 -s winget --accept-source-agreements --accept-package-agreements
    Write-Host "Python installation completed. Press any key to continue..."
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
    Show-DevelopmentMenu
}

function Install-GitTools {
    Write-Host "Installing Git and related tools..."
    winget install Git.Git -s winget --accept-source-agreements --accept-package-agreements
    Write-Host "Git installation completed. Press any key to continue..."
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
    Show-DevelopmentMenu
}