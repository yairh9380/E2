# Windows Optimization Manager Module

# Import utility functions and optimization modules
. "$PSScriptRoot\..\utils\logging.ps1"
. "$PSScriptRoot\optimization.ps1"

function Install-OptimizationModules {
    Write-Log "Installing and configuring optimization modules..."

    # Install required optimization tools
    Install-OptimizationTools

    # Apply Windows performance optimizations
    Optimize-WindowsPerformance

    # Apply Windows experience optimizations
    Optimize-WindowsExperience

    Write-Log "Optimization modules installation and configuration completed."
}

# Export functions for use in other modules
Export-ModuleMember -Function Install-OptimizationModules