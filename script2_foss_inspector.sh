#!/bin/bash
# ============================================================
# Script 2: FOSS Package Inspector
# Author:   Abhishek Shandilya
# Course:   Open Source Software Linux Administration
# Purpose:  Check whether a named open-source package is
#           installed, display version and licence info,
#           and print a philosophy note via a case statement.
# Usage:    ./script2_foss_inspector.sh
# ============================================================

# --- Define the primary package to inspect ---
# VLC is our chosen software; we also inspect a few others for the case statement
PACKAGE="vlc"

echo "================================================================"
echo "       FOSS PACKAGE INSPECTOR"
echo "================================================================"
echo ""

# --- Detect package manager and check if VLC is installed ---
# We support both APT (Debian/Ubuntu) and RPM (Fedora/CentOS/RHEL) systems

if command -v dpkg &>/dev/null; then
    # ---- APT-based systems (Debian, Ubuntu, etc.) ----
    echo "  Package manager detected: APT (dpkg)"
    echo ""

    if dpkg -l "$PACKAGE" 2>/dev/null | grep -q "^ii"; then
        # Package is installed (dpkg status "ii" = installed)
        echo "  [INSTALLED] $PACKAGE is present on this system."
        echo ""

        # Display version, licence summary, and description using dpkg -s
        echo "  --- Package Details ---"
        dpkg -s "$PACKAGE" 2>/dev/null | grep -E 'Version|Status|Maintainer|Homepage'

    else
        echo "  [NOT FOUND] $PACKAGE is NOT installed on this system."
        echo "  To install: sudo apt install vlc"
    fi

elif command -v rpm &>/dev/null; then
    # ---- RPM-based systems (Fedora, CentOS, RHEL) ----
    echo "  Package manager detected: RPM"
    echo ""

    if rpm -q "$PACKAGE" &>/dev/null; then
        echo "  [INSTALLED] $PACKAGE is present on this system."
        echo ""

        # Display key fields from the RPM database
        echo "  --- Package Details ---"
        rpm -qi "$PACKAGE" | grep -E 'Version|License|Summary|URL'

    else
        echo "  [NOT FOUND] $PACKAGE is NOT installed on this system."
        echo "  To install: sudo dnf install vlc  (after enabling RPM Fusion)"
    fi

else
    # Fallback if neither package manager is found
    echo "  Could not detect a supported package manager (apt/rpm)."
    echo "  Please verify VLC installation manually."
fi

echo ""
echo "----------------------------------------------------------------"

# --- Case statement: Philosophy notes for major FOSS packages ---
# The case statement matches a package name and prints a one-line
# philosophical note about why that software matters to open source.

echo "  Open Source Philosophy Notes:"
echo ""

# We loop through a list of notable FOSS packages for demonstration
for PKG_NAME in vlc httpd mysql-server firefox git python3; do

    case $PKG_NAME in
        vlc)
            echo "  vlc      : Born in a student lab in Paris — proves that"
            echo "             'plays everything' is possible without a price tag."
            ;;
        httpd | apache2)
            echo "  httpd    : Apache — the web server that built the open internet,"
            echo "             running roughly 30% of all websites since the 1990s."
            ;;
        mysql-server | mysql)
            echo "  mysql    : A dual-licence lesson — GPL for the community,"
            echo "             commercial for those who need proprietary embedding."
            ;;
        firefox)
            echo "  firefox  : A non-profit fighting to keep the web open against"
            echo "             browser monopolies — freedom in every rendered page."
            ;;
        git)
            echo "  git      : Linus Torvalds built it in two weeks when a proprietary"
            echo "             VCS failed him — now the foundation of all open collaboration."
            ;;
        python3 | python)
            echo "  python   : Shaped entirely by its community under the PSF licence —"
            echo "             proof that a language can be owned by everyone."
            ;;
        *)
            echo "  $PKG_NAME : An open-source tool — study its licence to understand"
            echo "             the freedoms it grants you."
            ;;
    esac

done

echo ""
echo "================================================================"
echo "  Shell scripting concepts used: if-then-else, command -v for"
echo "  tool detection, dpkg/rpm package queries, grep with -E,"
echo "  case statement, for loop over a list of values."
echo "================================================================"
