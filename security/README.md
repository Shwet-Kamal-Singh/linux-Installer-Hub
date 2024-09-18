# Linux Security Tools Installer

A collection of scripts to easily install essential security and privacy tools on Linux systems.

## Table of Contents

- [Available Scripts](#available-scripts)
- [Usage](#usage)
- [Compatibility](#compatibility)
- [Notes](#notes)
- [Disclaimer](#disclaimer)
- [Contributing](#contributing)
- [License](#license)

## Available Scripts

1. **install_nessus.sh**
   - Installs Nessus, a comprehensive vulnerability scanner

2. **install_protonvpn.sh**
   - Installs ProtonVPN, a secure VPN service with a focus on privacy

3. **install_steghide.sh**
   - Installs Steghide, a steganography program that hides data in various kinds of image and audio files

4. **main.sh**
   - Provides a menu-driven interface to install any or all of the above tools

## Usage

1. Clone the repository:
   ```bash
   git clone https://github.com/Shwet-Kamal-Singh/linux-Installer-Hub.git
   cd linux-Installer-Hub/security
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
- Ensure your system meets the requirements for each tool you're installing.
- Nessus may require a license for full functionality. Check Tenable's website for details.
- ProtonVPN requires an active subscription or free account for use.
- Some tools may not be available in the default repositories and might be installed from external sources.

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