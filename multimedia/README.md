# Linux Multimedia Tools Installer

A collection of scripts to easily install popular multimedia software on Linux systems.

## Table of Contents

- [Available Scripts](#available-scripts)
- [Usage](#usage)
- [Compatibility](#compatibility)
- [Notes](#notes)
- [Disclaimer](#disclaimer)
- [Contributing](#contributing)
- [License](#license)

## Available Scripts

1. **install_audacity.sh**
   - Installs Audacity, a free, open source, cross-platform audio software for multi-track recording and editing

2. **install_gimp.sh**
   - Installs GIMP (GNU Image Manipulation Program), a free and open-source raster graphics editor

3. **install_kdenlive.sh**
   - Installs Kdenlive, a free and open-source video editing software

4. **install_vlc.sh**
   - Installs VLC media player, a free and open-source, portable, cross-platform media player

5. **main.sh**
   - Provides a menu-driven interface to install any or all of the above tools

## Usage

1. Clone the repository:
   ```bash
   git clone https://github.com/Shwet-Kamal-Singh/linux-Installer-Hub.git
   cd linux-Installer-Hub/multimedia
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
- Ensure your system meets the requirements for each application you're installing.
- Some distributions may already include one or more of these applications. The scripts will update them if they're already present.
- Kdenlive may require additional multimedia codecs for full functionality, which the script will attempt to install.
- GIMP and Audacity might install additional dependencies for plugins and extended functionality.



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