# Safe Disk Unmounter (Bash)

## Overview
A simple Bash script to safely unmount external drives or partitions on Linux. 
It prevents data corruption by checking if the disk is currently in use (using `lsof`) before attempting to unmount.

## Features
* **Safety First:** Automatically checks for open files/processes.
* **Status Check:** Verifies if the disk is mounted before running.
* **Error Handling:** Provides clear feedback if the operation fails.

## Usage
1. Edit the `MOUNT_POINT` variable in the script.
2. Run: `sudo ./disk_unmounter.sh`