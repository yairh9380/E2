# Windows Configuration and Management Module

# Import utility functions
. "$PSScriptRoot\..\utils\logging.ps1"

function Set-RegistryValue {
    param (
        [string]$KeyPath,
        [string]$ValueName,
        $ValueData,
        [string]$ValueType = "DWord"
    )

    try {
        if ($KeyPath -match '^HKLM:\\') {
            $rootKey = "HKLM:"
        } else {
            $rootKey = "HKCU:"
        }
        $subKey = $KeyPath -replace '^(HKLM:|HKCU:)\\', ''
        
        if (!(Test-Path $KeyPath)) {
            New-Item -Path $KeyPath -Force | Out-Null
        }
        
        Set-ItemProperty -Path $KeyPath -Name $ValueName -Value $ValueData -Type $ValueType -ErrorAction Stop
        Write-Log "Successfully set registry value: $KeyPath\$ValueName" -Level Info
    } catch {
        Write-Log "Failed to set registry value: $KeyPath\$ValueName. Error: $($_.Exception.Message)" -Level Error
    }
}

function Optimize-SystemPerformance {
    Write-Log "Optimizing system performance..." -Level Info
    
    # Disable unnecessary services
    $servicesToDisable = @(
        "DiagTrack",     # Connected User Experiences and Telemetry
        "SysMain",       # Superfetch
        "WSearch"        # Windows Search
    )

    foreach ($service in $servicesToDisable) {
        try {
            Stop-Service -Name $service -Force -ErrorAction SilentlyContinue
            Set-Service -Name $service -StartupType Disabled -ErrorAction SilentlyContinue
            Write-Log "Disabled service: $service" -Level Info
        } catch {
            Write-Log "Failed to disable service: $service" -Level Error
        }
    }

    # Optimize power settings
    powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
    Write-Log "Set power plan to High Performance" -Level Info
}

function Set-PrivacySettings {
    Write-Log "Configuring privacy settings..." -Level Info
    
    # Disable telemetry
    Set-RegistryValue -KeyPath "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -ValueName "AllowTelemetry" -ValueData 0
    
    # Disable advertising ID
    Set-RegistryValue -KeyPath "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" -ValueName "Enabled" -ValueData 0
    
    # Disable app diagnostics
    Set-RegistryValue -KeyPath "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{2297E4E2-5DBE-466D-A12B-0F8286F0D9CA}" -ValueName "Value" -ValueData "Deny" -ValueType String
}

function Set-WindowsFeatures {
    Write-Log "Configuring Windows features..." -Level Info
    
    # Show file extensions
    Set-RegistryValue -KeyPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -ValueName "HideFileExt" -ValueData 0
    
    # Show hidden files
    Set-RegistryValue -KeyPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -ValueName "Hidden" -ValueData 1
    
    # Enable Developer Mode
    Set-RegistryValue -KeyPath "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" -ValueName "AllowDevelopmentWithoutDevLicense" -ValueData 1
}

function Get-SystemInformation {
    Write-Log "Gathering system information..." -Level Info
    
    $systemInfo = @{
        "OS Version" = (Get-WmiObject -Class Win32_OperatingSystem).Version
        "System Model" = (Get-WmiObject -Class Win32_ComputerSystem).Model
        "Processor" = (Get-WmiObject -Class Win32_Processor).Name
        "Memory (GB)" = [math]::Round((Get-WmiObject -Class Win32_ComputerSystem).TotalPhysicalMemory / 1GB, 2)
        "Disk Space (GB)" = [math]::Round((Get-WmiObject -Class Win32_LogicalDisk -Filter "DeviceID='C:'").Size / 1GB, 2)
    }
    
    $systemInfo.GetEnumerator() | ForEach-Object {
        Write-Log "$($_.Key): $($_.Value)" -Level Info
    }
    
    return $systemInfo
}

function Show-Menu {
    Write-Host ""
    Write-Host "Windows Configuration Menu" -ForegroundColor Cyan
    Write-Host "------------------------" -ForegroundColor Cyan
    Write-Host "1. Optimize System Performance"
    Write-Host "2. Configure Privacy Settings"
    Write-Host "3. Configure Windows Features"
    Write-Host "4. Display System Information"
    Write-Host "5. Apply All Settings"
    Write-Host "6. Exit"
    Write-Host ""
    
    $choice = Read-Host "Enter your choice (1-6)"
    return $choice
}

function Start-WindowsConfiguration {
    Write-Log "Starting Windows configuration..." -Level Info
    
    do {
        $choice = Show-Menu
        
        switch ($choice) {
            "1" { Optimize-SystemPerformance }
            "2" { Set-PrivacySettings }
            "3" { Set-WindowsFeatures }
            "4" { Get-SystemInformation }
            "5" {
                Optimize-SystemPerformance
                Set-PrivacySettings
                Set-WindowsFeatures
                Get-SystemInformation
            }
            "6" { 
                Write-Log "Exiting Windows configuration" -Level Info
                return 
            }
            default { Write-Log "Invalid choice. Please try again." -Level Warning }
        }
        
        if ($choice -ne "6") {
            Write-Host ""
            Read-Host "Press Enter to continue"
        }
        
    } while ($true)
}

# Execute configuration if script is run directly
if ($MyInvocation.InvocationName -ne "." -and $MyInvocation.InvocationName -ne ". ") {
    Start-WindowsConfiguration
}