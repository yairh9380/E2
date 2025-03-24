# PowerShell Profile Configuration

# Import Oh My Posh and set theme
oh-my-posh init pwsh --config "$env:USERPROFILE\.config\oh-my-posh\theme.omp.json" | Invoke-Expression

# Set aliases
Set-Alias -Name g -Value git
Set-Alias -Name c -Value clear

# Custom functions
function which ($command) {
    Get-Command -Name $command -ErrorAction SilentlyContinue |
        Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

# Set PSReadLine options
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView

# Environment variables
$env:EDITOR = 'code'
$env:VISUAL = 'code'

# Custom prompt configuration
function prompt {
    $location = Get-Location
    "$location> "
}