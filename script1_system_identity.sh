#!/bin/bash
# ============================================================
# Script 1: System Identity Report
# Author:   Abhishek Shandilya
# Course:   Open Source Software Linux Administration
# Purpose:  Display a formatted welcome/identity screen for
#           the Linux system, including distro, kernel,
#           user info, uptime, date, and OSS licence details.
# ============================================================

# --- Student & Project Variables ---
STUDENT_NAME="Abhishek Shandilya"            # TODO: Fill in your name
REG_NUMBER="24BCY10407"        # TODO: Fill in your registration number
SOFTWARE_CHOICE="VLC Media Player"     # Chosen open-source software

# --- Gather System Information using command substitution ---
KERNEL=$(uname -r)                            # Kernel version (e.g. 5.15.0-91-generic)
USER_NAME=$(whoami)                           # Current logged-in user
HOME_DIR=$HOME                                # Home directory of current user
UPTIME=$(uptime -p)                           # Human-readable uptime (e.g. "up 2 hours")
DATETIME=$(date '+%A, %d %B %Y  %H:%M:%S')  # Full date and time string

# --- Detect Linux Distribution ---
# /etc/os-release is a standard file on modern Linux systems
if [ -f /etc/os-release ]; then
    # Source the file to load distro variables, then use PRETTY_NAME
    . /etc/os-release
    DISTRO="${PRETTY_NAME}"
else
    # Fallback if the file is not present (older systems)
    DISTRO="Unknown Linux Distribution"
fi

# --- Determine OS Licence ---
# The Linux kernel (and most distros) use GPL v2 as their core licence
OS_LICENCE="GNU General Public License v2 (GPL v2)"

# --- Banner Display ---
echo "================================================================"
echo "       OPEN SOURCE AUDIT — SYSTEM IDENTITY REPORT              "
echo "================================================================"
echo ""

# --- Student Information ---
echo "  Student  : $STUDENT_NAME"
echo "  Reg. No. : $REG_NUMBER"
echo "  Project  : $SOFTWARE_CHOICE"
echo ""
echo "----------------------------------------------------------------"

# --- System Information ---
echo "  Distribution : $DISTRO"
echo "  Kernel       : $KERNEL"
echo "  Logged in as : $USER_NAME"
echo "  Home Dir     : $HOME_DIR"
echo "  Uptime       : $UPTIME"
echo "  Date & Time  : $DATETIME"
echo ""
echo "----------------------------------------------------------------"

# --- Licence Statement ---
echo "  This operating system is distributed under:"
echo "  $OS_LICENCE"
echo ""
echo "  VLC Media Player (your chosen software) is licensed under:"
echo "  GNU General Public License v2 (GPL v2)"
echo "  with libVLC under GNU Lesser General Public License v2.1 (LGPL)"
echo ""
echo "================================================================"
echo "  Shell scripting concepts used: variables, echo, command"
echo "  substitution \$(), conditional (-f file check), sourcing"
echo "  /etc/os-release, and formatted output with echo."
echo "================================================================"
