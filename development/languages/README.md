# Linux Programming Languages Installer

A comprehensive collection of scripts to easily install various programming languages and development environments on Linux systems.

## Table of Contents

- [Available Scripts](#available-scripts)
- [Usage](#usage)
- [Compatibility](#compatibility)
- [Notes](#notes)
- [Disclaimer](#disclaimer)
- [Contributing](#contributing)
- [License](#license)


## Available Scripts

1. **install_clang.sh**
   - Installs Clang, a C language family frontend for LLVM

2. **install_dart.sh**
   - Installs Dart programming language

3. **install_dotnet.sh**
   - Installs .NET Core SDK and runtime

4. **install_flutter.sh**
   - Installs Flutter SDK for building multi-platform applications

5. **install_gcc.sh**
   - Installs GNU Compiler Collection (GCC)

6. **install_go.sh**
   - Installs Go programming language

7. **install_java.sh**
   - Installs Java Development Kit (JDK)

8. **install_lua.sh**
   - Installs Lua programming language

9. **install_mono.sh**
   - Installs Mono, an open source implementation of Microsoft's .NET Framework

10. **install_nodejs.sh**
    - Installs Node.js JavaScript runtime

11. **install_python.sh**
    - Installs Python programming language

12. **install_ruby.sh**
    - Installs Ruby programming language

13. **main.sh**
    - Provides a menu-driven interface to install any or all of the above languages


## Usage

1. Clone the repository:
   ```bash
   git clone https://github.com/Shwet-Kamal-Singh/linux-Installer-Hub.git
   cd linux-Installer-Hub/development/languages
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
- Ensure your system meets the requirements for each language or SDK you're installing.
- Some languages may already be installed on your system. The scripts will update them if they're already present.
- For languages like Java, you may be prompted to choose between different versions (e.g., OpenJDK vs Oracle JDK).
- Flutter installation requires Dart, which will be installed automatically if not present.
- .NET Core and Mono installations may conflict. It's recommended to choose one based on your development needs.



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