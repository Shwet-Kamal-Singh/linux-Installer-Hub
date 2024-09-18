# Virtualization Tools Installer

Streamlined scripts for installing popular virtualization tools on Linux systems. Supports Docker, kubectl, and VirtualBox across multiple distributions, simplifying setup for developers and system administrators.

## Table of Contents

- [Available Scripts](#available-scripts)
- [Usage](#usage)
- [Compatibility](#compatibility)
- [Notes](#notes)
- [Disclaimer](#disclaimer)
- [Contributing](#contributing)
- [License](#license)

## Available Scripts

1. **install_docker.sh**
   - Installs Docker and optionally Docker Compose
   - Supports: Ubuntu, Debian, Linux Mint, CentOS, Red Hat, Fedora

2. **install_kubectl.sh**
   - Installs kubectl, the Kubernetes command-line tool
   - Supports most Linux distributions

3. **install_virtualbox.sh**
   - Installs VirtualBox and the VirtualBox Extension Pack
   - Supports: Ubuntu, Debian, Linux Mint, CentOS, Red Hat, Fedora

4. **main.sh**
   - Provides a menu-driven interface to install any or all of the above tools

## Usage

1. Clone the repository:
   ```bash
   git clone https://github.com/Shwet-Kamal-Singh/linux-Installer-Hub.git
   cd linux-Installer-Hub/virtualization
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

- Requires sudo privileges for installation and system modifications
- Ensure your system meets the requirements for each tool
- For Docker and VirtualBox, log out and back in for group changes to take effect
- The kubectl script only installs the command-line tool, not a Kubernetes cluster

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