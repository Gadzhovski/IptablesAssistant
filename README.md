
# Iptables Management and Testing Utility

![test2](https://github.com/Gadzhovski/IptablesAssistant/assets/93713208/48518a79-9127-4510-9067-1c936ff41f7e)


This Bash script is a command-line tool designed to manage iptables rules and test network connections. It is particularly useful for network administrators and security professionals who need to quickly modify iptables configurations and verify network connections.

## Features

- **Manage Iptables Rules**: Easily set, list, and clear iptables rules.
- **Test Network Connections**: Includes functionality to test connections to mail and web servers.
- **User-Friendly Menu**: Interactive menu-driven interface for ease of use.
- **Color-Coded Output**: Colorful output for better readability.
- **Customizable Port Settings**: Allows setting rules for specific ports.

## Prerequisites

- Bash shell (typically available on most Unix-based systems)
- sudo privileges
- iptables installed and configured on your system
- nc (netcat) for testing network connections


## Usage

To run the script, execute it with superuser privileges:

```bash
sudo ./iptables_utility.sh
```

Follow the on-screen prompts to select the desired action. The options include setting iptables policies, listing rules, testing network connections, and more.


## License

This project is licensed under the MIT License. See the LICENSE file for more details.

## Disclaimer

This tool is intended for educational and administrative purposes only. Please ensure you have the proper authorization before modifying iptables rules or testing network connectivity on any system.

## Credits
Project developed by Radoslav Gadzhovski as part of coursework for the University of Greenwich.
