
# User Management Project (Linux Bash Script)

This is a Linux-based **User Management Tool** written in Bash. It provides a menu-driven interface to perform common administrative tasks such as adding, deleting, locking, unlocking users, and more — with built-in validation and permission checks.

## Features

- Show system information
- List all users using `/bin/bash` shell
- Search for a user
- Add a user
- Delete a user (with home directory backup)
- View user details (using native commands)
- Change user password
- Lock and unlock user accounts
- Error handling for:
  - Invalid inputs
  - User existence checks
  - Backup directory validation
  - Permission checks (`sudo` where required)

## Prerequisites

- Linux OS
- Bash shell
- Root privileges (`sudo`)

## How to Use

1. **Download or clone this repository**
   ```bash
   git clone https://github.com/mohamed952741/user-management-script
   cd user-management-script
   ```

2. **Make the script executable**
   ```bash
   chmod +x project.sh
   ```

3. **Run the script with sudo**
   ```bash
   sudo ./project.sh
   ```

## Directory Structure

```
user-management-script/
│
├── project.sh       # Main executable script
└── README.md          # Project documentation
```

## Notes

- Backup directory will be created at `/backup` if not present.
- Only users with `/bin/bash` shell are listed.
- Uses native commands like `getent` and `lastlog` instead of external dependencies.
- Designed for educational and administrative automation purposes.

## Demo

[**Watch Demo Video**](https://drive.google.com/file/d/1nTxgx1fOTreGuQvEzwXUtxE1xbVUdVWW/view?usp=sharing)  
[**GitHub Project Link**](https://github.com/mohamed952741/user-management-script)

---

## License

This project is licensed under the [MIT License](LICENSE).
