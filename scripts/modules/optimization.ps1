# Windows Optimization Module

# Import utility functions
. "$PSScriptRoot\..\utils\logging.ps1"

function Optimize-WindowsPerformance {
    Write-Log "Optimizing Windows performance settings..."

    # Disable unnecessary visual effects
    Write-Log "Adjusting visual effects for better performance..."
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" -Name "VisualFXSetting" -Type DWord -Value 2

    # Disable unnecessary services
    Write-Log "Optimizing system services..."
    $servicesToDisable = @(
        "DiagTrack",              # Connected User Experiences and Telemetry
        "SysMain",                # Superfetch
        "WSearch"                 # Windows Search
    )

    foreach ($service in $servicesToDisable) {
        Stop-Service -Name $service -Force -ErrorAction SilentlyContinue
        Set-Service -Name $service -StartupType Disabled -ErrorAction SilentlyContinue
    }

    # Optimize power settings for performance
    Write-Log "Configuring power settings for high performance..."
    powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c # High Performance power plan

    # Disable Windows features that impact performance
    Write-Log "Disabling performance-impacting features..."
    Disable-WindowsOptionalFeature -Online -FeatureName "WindowsMediaPlayer" -NoRestart
    Disable-WindowsOptionalFeature -Online -FeatureName "Printing-XPSServices-Features" -NoRestart

    # Clean up system files
    Write-Log "Cleaning up system files..."
    cleanmgr /sagerun:1

    # Optimize disk
    Write-Log "Optimizing disk performance..."
    Optimize-Volume -DriveLetter C -ReTrim -Verbose

    Write-Log "Windows performance optimization completed."
}

function Optimize-WindowsExperience {
    Write-Log "Optimizing Windows user experience..."

    # Configure privacy settings
    Write-Log "Adjusting privacy settings..."
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Privacy" -Name "TailoredExperiencesWithDiagnosticDataEnabled" -Type DWord -Value 0

    # Customize taskbar settings
    Write-Log "Customizing taskbar settings..."
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarDa" -Type DWord -Value 0

    # Optimize Start Menu
    Write-Log "Optimizing Start Menu..."
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_TrackProgs" -Type DWord -Value 0

    # Configure system notifications
    Write-Log "Configuring system notifications..."
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\PushNotifications" -Name "ToastEnabled" -Type DWord -Value 0

    Write-Log "Windows experience optimization completed."
}

function Install-OptimizationTools {
    Write-Log "Installing optimization tools..."

    # Install system monitoring and optimization tools
    winget install Microsoft.Sysinternals.ProcessExplorer -s winget --accept-source-agreements --accept-package-agreements
    winget install Microsoft.Sysinternals.ProcessMonitor -s winget --accept-source-agreements --accept-package-agreements
    winget install Microsoft.Sysinternals.Autoruns -s winget --accept-source-agreements --accept-package-agreements

    Write-Log "Optimization tools installation completed."
}