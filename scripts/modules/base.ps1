# Base Applications Installation Module

# Import utility functions
. "$PSScriptRoot\..\utils\logging.ps1"

function Install-BaseApplications {
    Write-Log "Installing base applications..."

    # Terminal and shell
    Write-Log "Installing terminal and shell applications..."
    winget install Microsoft.WindowsTerminal -s winget --accept-source-agreements --accept-package-agreements
    winget install Microsoft.PowerShell -s winget --accept-source-agreements --accept-package-agreements

    # System utilities
    Write-Log "Installing system utilities..."
    winget install 7zip.7zip -s winget --accept-source-agreements --accept-package-agreements

    # Browsers
    Write-Log "Installing browsers..."
    winget install TheBrowserCompany.Arc -s winget --accept-source-agreements --accept-package-agreements

    # Media
    Write-Log "Installing media applications..."
    winget install VideoLAN.VLC -s winget --accept-source-agreements --accept-package-agreements

    # Communication and development tools
    Write-Log "Installing communication tools..."
    winget install GNU.Nano -s winget --accept-source-agreements --accept-package-agreements
    winget install OpenJS.NodeJS.LTS -s winget --accept-source-agreements --accept-package-agreements # Includes npm for yarn installation
    npm install -g yarn
    winget install GnuWin32.Wget -s winget --accept-source-agreements --accept-package-agreements

    # Productivity
    Write-Log "Installing productivity applications..."
    winget install Notepad++.Notepad++ -s winget --accept-source-agreements --accept-package-agreements

    Write-Log "Base applications installation completed."
}