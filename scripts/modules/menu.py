import logging
from typing import List, Dict
from dataclasses import dataclass

@dataclass
class MenuItem:
    name: str
    description: str
    features: List[str]
    enabled: bool = False

class MainMenu:
    def __init__(self):
        self.modules = {
            "performance": MenuItem(
                "Optimize Performance",
                "Boost system performance by streamlining resources",
                [
                    "Disable visual effects",
                    "Optimize startup programs",
                    "Clear temporary files",
                    "Defrag system drive",
                    "Adjust power settings"
                ]
            ),
            "apps": MenuItem(
                "Remove Unwanted Apps",
                "Uninstall pre-installed apps to free up space",
                [
                    "Remove bloatware",
                    "Uninstall Microsoft Store apps",
                    "Clean up Windows components",
                    "Remove temporary files"
                ]
            ),
            "privacy": MenuItem(
                "Enhance Privacy",
                "Protect your privacy and data",
                [
                    "Disable telemetry",
                    "Block data collection",
                    "Configure Windows Defender",
                    "Manage app permissions",
                    "Control diagnostic data"
                ]
            ),
            "features": MenuItem(
                "Manage Windows Features",
                "Enable or disable Windows features",
                [
                    "Developer mode",
                    "Windows subsystem for Linux",
                    "Hyper-V",
                    ".NET Framework",
                    "Internet Explorer"
                ]
            ),
            "network": MenuItem(
                "Networking Options",
                "Configure network settings",
                [
                    "Change DNS servers",
                    "Configure firewall",
                    "Network sharing settings",
                    "VPN configuration",
                    "Proxy settings"
                ]
            ),
            "info": MenuItem(
                "Device Information",
                "View system information",
                [
                    "Hardware specs",
                    "Windows version",
                    "Installed updates",
                    "Driver information",
                    "System health"
                ]
            )
        }

    def display_menu(self) -> None:
        """Display the main menu with all available modules"""
        print("\n=== El Capulin Windows Configuration Tool ===")
        print("\nAvailable modules:")
        for key, item in self.modules.items():
            status = "[Enabled]" if item.enabled else "[Disabled]"
            print(f"\n{item.name} {status}")
            print(f"  {item.description}")

    def display_submenu(self, module_key: str) -> None:
        """Display submenu for a specific module"""
        if module_key not in self.modules:
            print("Invalid module selection")
            return

        module = self.modules[module_key]
        print(f"\n=== {module.name} Features ===")
        for i, feature in enumerate(module.features, 1):
            print(f"{i}. {feature}")

    def toggle_module(self, module_key: str) -> None:
        """Toggle the enabled state of a module"""
        if module_key in self.modules:
            self.modules[module_key].enabled = not self.modules[module_key].enabled
            status = "enabled" if self.modules[module_key].enabled else "disabled"
            print(f"Module {self.modules[module_key].name} {status}")

    def get_enabled_features(self) -> Dict[str, List[str]]:
        """Get all enabled features grouped by module"""
        enabled_features = {}
        for key, item in self.modules.items():
            if item.enabled:
                enabled_features[key] = item.features
        return enabled_features

def main():
    menu = MainMenu()
    while True:
        menu.display_menu()
        print("\nOptions:")
        print("1-6. Select module to configure")
        print("q. Quit")
        
        choice = input("\nEnter your choice: ").lower()
        
        if choice == 'q':
            break
        
        try:
            module_index = int(choice) - 1
            if 0 <= module_index < len(menu.modules):
                module_key = list(menu.modules.keys())[module_index]
                menu.display_submenu(module_key)
                menu.toggle_module(module_key)
            else:
                print("Invalid selection")
        except ValueError:
            print("Invalid input")

if __name__ == '__main__':
    main()