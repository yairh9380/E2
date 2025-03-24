<h1 align="center">El Capulin - Windows 11 Dotfiles</h1>

<p align="center">El Capulin is a comprehensive Windows 11 dotfiles repository designed to streamline the setup and configuration of development environments. This project automates the installation and configuration of essential tools, applications, and settings for Windows 11 systems.</p>

![App Screenshot](/assets/img/elcapulin.webp)

## Features
- Automated Windows 11 configuration and optimization
- Development environment setup (VS Code, Git, etc.)
- Terminal customization with Oh My Posh
- Package management through Chocolatey
- PowerShell profile configuration

## Prerequisites
- Windows 11
- PowerShell 5.1 or later
- Administrator privileges

## Project Structure
```
c:\Users\canoy\Desktop\ElCapulin dotfiles
├── .github/
│   └── workflows/
│       └── test-scripts.yml       # CI/CD pipeline configuration
├── scripts/
│   ├── setup.ps1                  # Main setup script
│   ├── modules/
│   │   ├── windows.ps1            # Windows activation and settings
│   │   ├── packages.ps1           # Chocolatey and package installation
│   │   ├── terminal.ps1           # Terminal and Oh My Posh setup
│   │   ├── vscode.ps1             # VS Code configuration
│   │   └── dev.ps1               # Development environment setup
│   └── utils/
│       ├── check-admin.ps1        # Administrative privileges check
│       └── logging.ps1            # Logging utilities
├── config/
│   ├── terminal/
│   │   ├── settings.json          # Windows Terminal settings
│   │   └── oh-my-posh/
│   │       ├── theme.omp.json     # Custom Oh My Posh theme
│   │       └── plugins/           # Oh My Posh plugins
│   ├── powershell/
│   │   └── Microsoft.PowerShell_profile.ps1  # PowerShell profile
│   └── vscode/
│       ├── settings.json          # VS Code settings
│       └── extensions.list        # VS Code extensions
├── packages/
│   ├── base.txt                   # Basic system utilities
│   └── dev.txt                    # Development tools and packages
└── docs/
    ├── README.md                  # Project documentation
    └── CUSTOMIZATION.md           # Customization guide
```

## Installation
1. Clone the repository:
   ```powershell
   git clone https://github.com/yourusername/elcapulin-dotfiles.git
   cd elcapulin-dotfiles
   ```

2. Run the setup script with administrator privileges:
   ```powershell
   Set-ExecutionPolicy Bypass -Scope Process -Force
   .\scripts\setup.ps1
   ```

## Customization
Refer to `docs/CUSTOMIZATION.md` for detailed instructions on:
- Modifying Windows Terminal settings
- Customizing Oh My Posh themes
- Adjusting VS Code configurations
- Adding or removing packages

## Contributing
1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License
This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments
- [Oh My Posh](https://ohmyposh.dev/)
- [Chocolatey](https://chocolatey.org/)
- [Windows Terminal](https://github.com/microsoft/terminal)