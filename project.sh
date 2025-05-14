#!/bin/bash

# Ensure the script is run with sudo/root
#if [ "$EUID" -ne 0 ]; then
#    echo "Please run this script with sudo or as root."
#    exit 1
#fi

# Ensure backup directory exists
BACKUP_ROOT="backup"
if [ ! -d "$BACKUP_ROOT" ]; then
    echo "Creating backup directory at $BACKUP_ROOT..."
    mkdir -p "$BACKUP_ROOT" || { echo "Failed to create backup directory. Exiting."; exit 1; }
fi

while true; do
    echo -e "\n User Management Menu:"
    echo "1. Show system information"
    echo "2. List users with /bin/bash shell"
    echo "3. Search for a user"
    echo "4. Add user"
    echo "5. Delete user (with home backup)"
    echo "6. Show user details"
    echo "7. Change user password"
    echo "8. Lock user"
    echo "9. Unlock user"
    echo "10. Exit"
    read -p "Enter your choice [1-10]: " choice

    case "$choice" in
        1)
            echo -e "\n System Information:"
            uname -a
            ;;
        2)
            echo -e "\n Users with /bin/bash shell:"
            awk -F: '/\/bin\/bash$/ {print $1}' /etc/passwd
            ;;
        3)
            read -p "Enter username to search: " uname
            if id "$uname" &>/dev/null; then
                echo " User '$uname' exists."
            else
                echo " User '$uname' not found."
            fi
            ;;
        4)
            read -p "Enter new username: " uname
            if id "$uname" &>/dev/null; then
                echo " User '$uname' already exists."
            else
                sudo adduser "$uname"
            fi
            ;;
        5)
            read -p "Enter username to delete: " uname
            if ! id "$uname" &>/dev/null; then
                echo " User '$uname' does not exist."
                continue
            fi
            backup_dir="$BACKUP_ROOT/$uname"
            echo "Backing up /home/$uname to $backup_dir..."
            cp -r "/home/$uname" "$backup_dir" 2>/dev/null || echo "Backup failed or home directory missing."
            sudo deluser --remove-home "$uname"
            echo "User '$uname' deleted."
            ;;
        6)
            read -p "Enter username: " uname
            if id "$uname" &>/dev/null; then
                echo "Username : $uname"
		echo "Info: $(getent passwd "$uname")"
		echo "Last Login:" 
		lastlog -u "$uname"
            else
                echo "User not found."
            fi
            ;;
        7)
            read -p "Enter username: " uname
            if id "$uname" &>/dev/null; then
                sudo passwd "$uname"
            else
                echo "User not found."
            fi
            ;;
        8)
            read -p "Enter username to lock: " uname
            if id "$uname" &>/dev/null; then
                sudo usermod -L "$uname"
                echo "User '$uname' locked."
            else
                echo "User not found."
            fi
            ;;
        9)
            read -p "Enter username to unlock: " uname
            if id "$uname" &>/dev/null; then
                sudo usermod -U "$uname"
                echo "User '$uname' unlocked."
            else
                echo "User not found."
            fi
            ;;
        10)
            echo "Exiting..."
            break
            ;;
        *)
            echo "Invalid input. Please select a number between 1 and 10."
            ;;
    esac
done
