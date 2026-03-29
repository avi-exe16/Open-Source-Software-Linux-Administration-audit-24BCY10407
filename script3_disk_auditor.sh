#!/bin/bash
# ============================================================
# Script 3: Disk and Permission Auditor
# Author:   Abhishek Shandilya
# Course:   Open Source Software Linux Administration
# Purpose:  Loop through key Linux system directories and
#           report disk usage, owner, group, and permissions.
#           Also checks for VLC's configuration directory.
# ============================================================

# --- Define the list of directories to audit ---
# These are standard Linux directory paths every OSS student should know
DIRS=("/etc" "/var/log" "/home" "/usr/bin" "/tmp" "/usr/lib" "/var")

# --- VLC-specific directories to check ---
VLC_DIRS=(
    "/usr/bin"               # Location of the vlc executable
    "/usr/lib/vlc"           # VLC plugin modules directory
    "/usr/share/vlc"         # VLC shared data (skins, help files)
    "$HOME/.config/vlc"      # Per-user VLC configuration directory
)

echo "================================================================"
echo "       DISK AND PERMISSION AUDITOR"
echo "================================================================"
echo ""
echo "  Format: [path] => Perms: [rwx bits] Owner Group | Size: [size]"
echo ""
echo "  --- Standard System Directories ---"
echo "  -------------------------------------------------------"

# --- Main audit loop using a for loop ---
# For each directory in our list, we check if it exists,
# then extract permissions and size using ls and du.

for DIR in "${DIRS[@]}"; do

    if [ -d "$DIR" ]; then
        # ls -ld: long listing of the directory itself (not its contents)
        # awk '{print $1, $3, $4}' extracts: permissions, owner, group
        PERMS=$(ls -ld "$DIR" | awk '{print $1, $3, $4}')

        # du -sh: human-readable total size of directory and all contents
        # 2>/dev/null suppresses "permission denied" errors for protected dirs
        # cut -f1 takes only the size column (before the tab)
        SIZE=$(du -sh "$DIR" 2>/dev/null | cut -f1)

        # Print formatted result
        printf "  %-20s => Perms: %-30s | Size: %s\n" "$DIR" "$PERMS" "${SIZE:-N/A}"
    else
        # Directory does not exist on this system
        printf "  %-20s => [DOES NOT EXIST on this system]\n" "$DIR"
    fi

done

echo ""
echo "  --- VLC Software Directories ---"
echo "  -------------------------------------------------------"

# --- Check VLC-specific directories ---
# This demonstrates how open-source software organises itself on Linux
for VDIR in "${VLC_DIRS[@]}"; do

    if [ -d "$VDIR" ]; then
        VPERMS=$(ls -ld "$VDIR" | awk '{print $1, $3, $4}')
        VSIZE=$(du -sh "$VDIR" 2>/dev/null | cut -f1)
        printf "  %-28s => Perms: %-28s | Size: %s\n" "$VDIR" "$VPERMS" "${VSIZE:-N/A}"
    else
        printf "  %-28s => [NOT FOUND — VLC may not be installed]\n" "$VDIR"
    fi

done

echo ""
echo "  --- VLC Executable Check ---"
echo "  -------------------------------------------------------"

# Check if the vlc binary exists in /usr/bin
VLC_BIN="/usr/bin/vlc"
if [ -f "$VLC_BIN" ]; then
    # ls -lh gives a human-readable listing of the file
    ls -lh "$VLC_BIN"
    echo "  VLC binary is present and executable."
else
    echo "  $VLC_BIN not found. VLC does not appear to be installed."
fi

echo ""
echo "================================================================"
echo "  Shell scripting concepts used: for loop with array, if [ -d ]"
echo "  directory check, if [ -f ] file check, ls -ld, du -sh, awk,"
echo "  cut, printf for formatted output, 2>/dev/null error redirection."
echo "================================================================"
