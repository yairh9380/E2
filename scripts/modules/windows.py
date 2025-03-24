return the .ps1 powershell all the proyectimport winreg
import logging
from pathlib import Path

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)

def set_registry_value(key_path: str, value_name: str, value_data, value_type=winreg.REG_DWORD):
    """Set a Windows registry value"""
    try:
        root_key = winreg.HKEY_LOCAL_MACHINE if key_path.startswith('HKLM') else winreg.HKEY_CURRENT_USER
        sub_key = key_path.split('\\', 1)[1]
        
        with winreg.OpenKey(root_key, sub_key, 0, winreg.KEY_SET_VALUE) as key:
            winreg.SetValueEx(key, value_name, 0, value_type, value_data)
            logging.info(f'Successfully set registry value: {key_path}\\{value_name}')
    except Exception as e:
        logging.error(f'Failed to set registry value: {key_path}\\{value_name}. Error: {str(e)}')

def configure_windows():
    """Configure Windows settings"""
    logging.info('Configuring Windows settings...')
    
    # Enable Developer Mode
    set_registry_value(
        'HKLM\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\AppModelUnlock',
        'AllowDevelopmentWithoutDevLicense',
        1
    )
    
    # Show file extensions
    set_registry_value(
        'HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Explorer\\Advanced',
        'HideFileExt',
        0
    )
    
    # Show hidden files
    set_registry_value(
        'HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Explorer\\Advanced',
        'Hidden',
        1
    )
    
    # Disable Windows Defender SmartScreen
    set_registry_value(
        'HKLM\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Explorer',
        'SmartScreenEnabled',
        'Off',
        winreg.REG_SZ
    )
    
    logging.info('Windows configuration completed successfully')

if __name__ == '__main__':
    configure_windows()