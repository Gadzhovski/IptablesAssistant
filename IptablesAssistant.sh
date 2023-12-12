#!/bin/bash

# make sure the script is being executed with superuser privileges
if [[ "${UID}" -ne 0 ]]
then
    echo "Please run with sudo or as root."
    exit 1
fi

# Clear the terminal 
clear

# Display ASCII art in purple
echo -e "\033[0;35m"  # Set color to purple
cat << "EOF"
    ____      __        __    __             ___              _      __              __ 
   /  _/___  / /_____ _/ /_  / /__  _____   /   |  __________(_)____/ /_____ _____  / /_
   / // __ \/ __/ __ `/ __ \/ / _ \/ ___/  / /| | / ___/ ___/ / ___/ __/ __ `/ __ \/ __/
 _/ // /_/ / /_/ /_/ / /_/ / /  __(__  )  / ___ |(__  |__  ) (__  ) /_/ /_/ / / / / /_  
/___/ .___/\__/\__,_/_.___/_/\___/____/  /_/  |_/____/____/_/____/\__/\__,_/_/ /_/\__/  
   /_/                                                                                  
EOF
echo -e "\033[0m"  # Reset color

# Define some colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

execute_command() {
    local message="$1" # Message to display
    local command="$2" # Command to execute
    
    echo -e "${YELLOW}### $message ###${NC}"
    eval "$command"
    echo -e "\n----------------------------------\n"
    read -p "Press any key to continue..."
    clear
}

# Ask user for input
while true; do
    echo -e "${GREEN}Select an option:${NC}"
    echo "1: Set default DROP policy for OUTPUT chain"
    echo "2: List current iptables rules"
    echo "3: Test connection to mail server and web server"
    echo "4: Allow HTTP on port 80 for OUTPUT chain"
    echo "5: Allow SMTP on port 25 for OUTPUT chain"
    echo "6: Allow communication on port 8888 for OUTPUT chain"
    echo "7: Clear all iptables rules"
    echo "8: Revert policies and test connections"
    echo ""
    echo -e "${RED}For testing:${NC}"
    echo "9: List current iptables rules"
    echo "10: Set all chains to ACCEPT"
    echo "11: Set all chains to DROP"
    echo "12: Set individual chain to ACCEPT"
    echo "13: Set individual chain to DROP"
    echo ""
    echo "14: Exit"

    read -p "Enter choice [1-14]: " choice

    # Check if choice is a number
    case $choice in
        1) execute_command "Setting default DROP policy for OUTPUT chain" "sudo iptables --policy OUTPUT DROP";;
        2) execute_command "Listing current iptables rules" "sudo iptables -L";;
        3) execute_command "Attempting to connect to mail server on 192.168.69.200" "echo -e 'EHLO test.com\nQUIT' | nc -v 192.168.69.200 25 2>&1"
            read -p "Press Enter to test the HTTP connection..."
            execute_command "Attempting to connect to web server on 192.168.69.164" "echo -e 'GET / HTTP/1.1\nHost: 192.168.69.164\n\n' | nc -v 192.168.69.164 80 2>&1"
            ;;
        4) execute_command "Allowing HTTP on port 80 for OUTPUT chain" "sudo iptables -A OUTPUT -p tcp --dport 80 -j ACCEPT";;
        5) execute_command "Allowing SMTP on port 25 for OUTPUT chain" "sudo iptables -A OUTPUT -p tcp --dport 25 -j ACCEPT";;
        6) execute_command "Allowing communication on port 8888 for OUTPUT chain" "sudo iptables -A OUTPUT -p tcp --dport 8888 -j ACCEPT";;
        7) execute_command "Clearing all iptables rules" "sudo iptables -F";;
        8) execute_command "Setting default ACCEPT policy for OUTPUT chain" "sudo iptables --policy OUTPUT ACCEPT"
           execute_command "Setting default DROP policy for INPUT chain" "sudo iptables --policy INPUT DROP"
           execute_command "Attempting to connect to mail server on 192.168.69.200 after changes" "nc -zv 192.168.69.200 25 2>&1"
           execute_command "Attempting to connect to web server on 192.168.69.164 after changes" "nc -zv 192.168.69.164 80 2>&1";;
        9) execute_command "Listing current iptables rules" "sudo iptables -L";;
        10) execute_command "Setting all chains to ACCEPT" "sudo iptables --policy INPUT ACCEPT && sudo iptables --policy FORWARD ACCEPT && sudo iptables --policy OUTPUT ACCEPT";;
        11) execute_command "Setting all chains to DROP" "sudo iptables --policy INPUT DROP && sudo iptables --policy FORWARD DROP && sudo iptables --policy OUTPUT DROP";;
        12)
           read -p "Enter chain name (INPUT, FORWARD, OUTPUT): " chain
           execute_command "Setting $chain chain to ACCEPT" "sudo iptables --policy $chain ACCEPT";;
        13)
           read -p "Enter chain name (INPUT, FORWARD, OUTPUT): " chain
           execute_command "Setting $chain chain to DROP" "sudo iptables --policy $chain DROP";;
        14) break;;
        *) echo -e "${RED}Invalid option${NC}";;
    esac
done
