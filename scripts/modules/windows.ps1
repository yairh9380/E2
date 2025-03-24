# Windows 11 Configuration Module

# Import utility functions
. "$PSScriptRoot\..\utils\logging.ps1"

function Set-WindowsConfiguration {
    Write-Log "Configuring Windows settings..."
    
    # Enable Developer Mode
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" -Name "AllowDevelopmentWithoutDevLicense" -Value 1
    
    # Show file extensions
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Value 0
    
    # Show hidden files
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Hidden" -Value 1
    
    # Disable Windows Defender SmartScreen
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -Name "SmartScreenEnabled" -Value "Off"
    
    Write-Log "Windows configuration completed successfully" -Level Info
}

# Execute configuration
Set-WindowsConfiguration