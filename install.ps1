# ElCapulin Windows Configuration Script

# Import modules
. "$PSScriptRoot\scripts\modules\base.ps1"
. "$PSScriptRoot\scripts\modules\optimization_manager.ps1"
. "$PSScriptRoot\scripts\utils\menu.ps1"

# Create logging directory if it doesn't exist
$logDir = "$PSScriptRoot\logs"
if (-not (Test-Path -Path $logDir)) {
    New-Item -ItemType Directory -Path $logDir | Out-Null
}

# Start the menu system
Show-MainMenu