#!/bin/bash

# Configuration
MOUNT_POINT="/mnt/wsl/docker-desktop/docker-desktop-user-distro"
DEVICE="/dev/sdc"

# Helper function: Check if any process is locking the directory
check_disk_usage() {
    # 'lsof' checks for open files in the mount point
    lsof +D "$MOUNT_POINT" > /dev/null 2>&1
    
    if [ $? -eq 0 ]; then
        echo "Error: Disk is busy. Close files/processes first."
        return 1
    else
        return 0
    fi
}

# Main Logic
# 1. Verify if the disk is actually mounted
if mount | grep "$MOUNT_POINT" > /dev/null; then
    echo "Disk found at $MOUNT_POINT."

    # 2. Safety Check: Don't unmount if in use
    echo "Checking for active processes..."
    if ! check_disk_usage; then
        echo "Aborting: Disk is in use."
        exit 1
    fi

    # 3. Attempt to unmount safely
    echo "Unmounting $DEVICE..."
    sudo umount "$MOUNT_POINT"

    if [ $? -eq 0 ]; then
        echo "Success: $DEVICE unmounted."
    else
        echo "Error: Failed to unmount. Check permissions or force unmount."
    fi

else
    echo "Error: $DEVICE is not mounted. Nothing to do."
    exit 1
fi