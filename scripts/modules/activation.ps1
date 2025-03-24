# Windows Activation Module

function Invoke-WindowsActivation {
    param(
        [switch]$NoEditionChange
    )

    $logFile = "$PSScriptRoot\..\..\logs\activation.log"
    
    # Check Windows version
    $winBuild = [System.Environment]::OSVersion.Version.Build
    if ($winBuild -lt 10240) {
        Write-Error "Windows Activation is only supported on Windows 10/11."
        Add-Content $logFile "[$(Get-Date)] Error: Unsupported Windows version detected (Build: $winBuild)"
        return $false
    }

    # Check if running on Windows Server
    if (Test-Path "$env:SystemRoot\Servicing\Packages\Microsoft-Windows-Server*Edition~*.mum") {
        Write-Error "Windows Activation is not supported on Windows Server."
        Add-Content $logFile "[$(Get-Date)] Error: Windows Server detected, activation not supported"
        return $false
    }

    try {
        # Get current Windows edition
        $edition = (Get-WindowsEdition -Online).Edition
        Add-Content $logFile "[$(Get-Date)] Current Windows Edition: $edition"

        # Attempt HWID activation
        $result = Start-Process "slmgr.vbs" -ArgumentList "/ato" -NoNewWindow -Wait -PassThru
        
        if ($result.ExitCode -eq 0) {
            Write-Host "Windows activation completed successfully." -ForegroundColor Green
            Add-Content $logFile "[$(Get-Date)] Activation successful"
            return $true
        } else {
            Write-Error "Windows activation failed with exit code: $($result.ExitCode)"
            Add-Content $logFile "[$(Get-Date)] Activation failed with exit code: $($result.ExitCode)"
            return $false
        }
    }
    catch {
        Write-Error "An error occurred during activation: $_"
        Add-Content $logFile "[$(Get-Date)] Error during activation: $_"
        return $false
    }
}

# Export functions
Export-ModuleMember -Function Invoke-WindowsActivation