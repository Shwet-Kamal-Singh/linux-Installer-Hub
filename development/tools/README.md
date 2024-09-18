# Linux Development Tools Installer

A collection of scripts to easily install essential development tools on Linux systems.

## Table of Contents

- [Available Scripts](#available-scripts)
- [Usage](#usage)
- [Compatibility](#compatibility)
- [Notes](#notes)
- [Disclaimer](#disclaimer)
- [Contributing](#contributing)
- [License](#license)

## Available Scripts

1. **install_git.sh**
   - Installs Git, the distributed version control system

2. **install_sublime_text.sh**
   - Installs Sublime Text, a sophisticated text editor for code, markup, and prose

3. **install_vscode.sh**
   - Installs Visual Studio Code, a lightweight but powerful source code editor

4. **main.sh**
   - Provides a menu-driven interface to install any or all of the above tools


## Usage

1. Clone the repository:
   ```bash
   git clone https://github.com/Shwet-Kamal-Singh/linux-Installer-Hub.git
   cd linux-Installer-Hub/development/tools
   ```

2. Make scripts executable:
   ```bash
   chmod +x *.sh
   ```

3. Run the main script:
   ```bash
   ./main.sh
   ```

4. Follow on-screen prompts to install desired tools.

## Compatibility

| Distribution       | Support |
|--------------------|---------|
| AlmaLinux 8        | ✅      |
| Amazon Linux 2     | ✅ 🤖   |
| Arch Linux         | ✅      |
| CentOS 7           | ✅ 🤖   |
| CentOS Stream >= 8 | ✅ 🤖   |
| Debian >= 10       | ✅ 🤖   |
| Fedora >= 35       | ✅ 🤖   |
| Oracle Linux 8     | ✅      |
| Rocky Linux 8      | ✅      |
| Ubuntu >= 18.04    | ✅ 🤖   |

Other Linux distributions may work but are not officially supported by these scripts.

## Notes

- These scripts require sudo privileges to install packages and modify system settings.
- Git is often pre-installed on many Linux distributions. The script will update it if it's already present.
- Sublime Text and Visual Studio Code are proprietary software, although VS Code has an open-source version called VSCodium.
- The installation scripts for Sublime Text and VS Code will add the necessary repositories to your system for future updates.
- After installation, you may need to restart your terminal or log out and back in for all changes to take effect.


## Disclaimer

These scripts are provided as-is, without warranty. Review before running, especially those requiring sudo privileges.



## Contributing

Contributions to improve this script are welcome. Please fork the repository, create a new branch for your feature or bug fix, make your changes, and submit a pull request with a clear description of your modifications.

## License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/Shwet-Kamal-Singh/linux-Installer-Hub/blob/main/LICENSE) file for details.

![Original Creator](https://img.shields.io/badge/Original%20Creator-Shwet%20Kamal%20Singh-blue)

![License](https://img.shields.io/badge/License-MIT-green)

## Contact

For any inquiries or permissions, please contact:
- Email: shwetkamalsingh55@gmail.com
- LinkedIn: https://www.linkedin.com/in/shwet-kamal-singh/
- GitHub: https://github.com/Shwet-Kamal-Singh