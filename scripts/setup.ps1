# El Capulin - Windows 11 Setup Script

# Import utility functions
. "$PSScriptRoot\utils\check-admin.ps1"
. "$PSScriptRoot\utils\logging.ps1"

# Función para verificar dependencias
function Test-Dependencies {
    try {
        Write-Log "Verificando dependencias del sistema..." -Level Info
        
        # Verificar versión de PowerShell
        if ($PSVersionTable.PSVersion.Major -lt 5) {
            Write-Log "Se requiere PowerShell 5 o superior" -Level Error
            return $false
        }
        
        # Verificar conexión a internet
        if (-not (Test-Connection -ComputerName 8.8.8.8 -Count 1 -Quiet)) {
            Write-Log "No se detectó conexión a internet" -Level Error
            return $false
        }
        
        Write-Log "Todas las dependencias verificadas correctamente" -Level Info
        return $true
    } catch {
        Write-Log "Error al verificar dependencias: $($_.Exception.Message)" -Level Error
        return $false
    }
}

# Check if running as administrator
if (-not (Test-IsAdmin)) {
    Write-Log "Este script debe ejecutarse como Administrador" -Level Error
    exit 1
}

# Verificar dependencias antes de continuar
if (-not (Test-Dependencies)) {
    Write-Log "No se cumplieron los requisitos necesarios para la ejecución" -Level Error
    exit 1
}

# Import and run module scripts
$modules = @(
    "windows",
    "packages",
    "terminal",
    "dev"
)

foreach ($module in $modules) {
    Write-Log "Setting up $module..."
    try {
        . "$PSScriptRoot\modules\$module.ps1"
    } catch {
        Write-Error "Failed to import module: $module"
        Write-Error $_.Exception.Message
        exit 1
    }
}

Write-Log "Setup completed successfully!"