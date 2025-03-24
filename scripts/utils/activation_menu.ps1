# Windows Activation Menu Module

# Import required utility functions
. "$PSScriptRoot\check-admin.ps1"
. "$PSScriptRoot\logging.ps1"

function Show-ActivationMenu {
    if (-not (Test-IsAdmin)) {
        Write-Log "El menú de activación requiere privilegios de administrador" -Level Error
        return
    }

    Clear-Host
    Write-Log "Iniciando menú de activación de Windows" -Level Info
    Write-Host "Windows Activation Menu" -ForegroundColor Cyan
    Write-Host "==================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "1. Activate Windows"
    Write-Host "2. Check Activation Status"
    Write-Host "3. Back to Main Menu"
    Write-Host ""
    
    $choice = Read-Host "Enter your choice"
    
    switch ($choice) {
        "1" {
            try {
                Write-Log "Iniciando proceso de activación de Windows" -Level Info
                Write-Host "\nAttempting Windows Activation..." -ForegroundColor Yellow
                $result = Invoke-WindowsActivation
                if ($result) {
                    Write-Log "Activación de Windows completada exitosamente" -Level Info
                }
                Write-Host "Press any key to continue..."
                $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
                Show-ActivationMenu
            } catch {
                Write-Log "Error durante la activación: $($_.Exception.Message)" -Level Error
                Write-Host "Error durante la activación" -ForegroundColor Red
                Write-Host "Press any key to continue..."
                $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
                Show-ActivationMenu
            }
        }
        "2" {
            try {
                Clear-Host
                Write-Log "Verificando estado de activación" -Level Info
                Write-Host "Current Activation Status:" -ForegroundColor Cyan
                Write-Host "======================" -ForegroundColor Cyan
                Write-Host ""
                $status = Get-CimInstance -ClassName SoftwareLicensingProduct | Where-Object { $_.PartialProductKey -and $_.Name -like "Windows*" }
                if ($status) {
                    Write-Host "License Status: $($status.LicenseStatus)"
                    Write-Host "Product Name: $($status.Name)"
                    Write-Log "Estado de activación recuperado exitosamente" -Level Info
                } else {
                    Write-Log "No se pudo obtener el estado de activación" -Level Warning
                    Write-Host "No se pudo obtener información de la licencia" -ForegroundColor Yellow
                }
                Write-Host ""
                Write-Host "Press any key to continue..."
                $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
                Show-ActivationMenu
            } catch {
                Write-Log "Error al verificar el estado de activación: $($_.Exception.Message)" -Level Error
                Write-Host "Error al verificar el estado de activación" -ForegroundColor Red
                Write-Host ""
                Write-Host "Press any key to continue..."
                $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
                Show-ActivationMenu
            }
        }
        "3" {
            . "$PSScriptRoot\menu.ps1"
            Show-MainMenu
        }
        default {
            Write-Host "\nInvalid choice. Please try again." -ForegroundColor Red
            Start-Sleep -Seconds 2
            Show-ActivationMenu
        }
    }
}

# Export functions
Export-ModuleMember -Function Show-ActivationMenu