# Open-Source-Software-Linux-Administration-audit-24BCY10407
Open Source Audit — VLC Media Player | OSS NGMC Capstone | 5 shell scripts | 24BCY10407
---
Field	Details
Student Name  - Abhishek Shandilya
Registration Number	 - 24BCY10407
Chosen Software	VLC Media Player
Licence (Software)	GPL v2 (core) / LGPL v2.1 (libVLC)
Course - 	Open Source Software Linux Administration
---
About This Project
This repository contains the shell scripts and supporting files for the Open Source Audit capstone. The audit examines VLC Media Player — its origin, its GPL v2 licence, its Linux footprint, its position in the FOSS ecosystem, and how it compares to proprietary alternatives.
VLC was created by students at École Centrale Paris in 1996 to stream video across a campus network. It has since become the world's most downloaded media player, with over five billion downloads, running on every major operating system and playing virtually every media format — all without charging users a single rupee.
---
Repository Contents
```
Open-Source-Software-Linux-Administration-audit-24BCY10407/
├── README.md
├── scripts/
│   ├── script1_system_identity.sh
│   ├── script2_foss_inspector.sh
│   ├── script3_disk_auditor.sh
│   ├── script4_log_analyzer.sh
│   └── script5_manifesto_generator.sh
Script Descriptions
Script 1 — System Identity Report (`script1_system_identity.sh`)
Displays a formatted welcome screen for the Linux system, showing the distribution name, kernel version, current user, home directory, system uptime, date and time, and the open-source licence covering the operating system and VLC.
Concepts: variables, `echo`, command substitution `$()`, sourcing `/etc/os-release`, conditional `-f` file check, formatted output.
---
Script 2 — FOSS Package Inspector (`script2_foss_inspector.sh`)
Checks whether VLC is installed on the system using either `dpkg` (Debian/Ubuntu) or `rpm` (Fedora/CentOS). Displays version, status, and maintainer details. Uses a `case` statement to print a one-line open source philosophy note for several major FOSS packages.
Concepts: `if-then-else`, `command -v` for tool detection, `dpkg -s` / `rpm -qi`, `grep -E`, `case` statement, `for` loop.
---
Script 3 — Disk and Permission Auditor (`script3_disk_auditor.sh`)
Loops through a list of important Linux system directories and reports their permissions, owner, group, and disk usage. Also specifically checks VLC's installation directories (`/usr/lib/vlc`, `/usr/share/vlc`, `~/.config/vlc`) and the VLC binary.
Concepts: `for` loop with arrays, `if [ -d ]` and `if [ -f ]`, `ls -ld`, `du -sh`, `awk`, `cut`, `printf` for aligned output, `2>/dev/null` error redirection.
---
Script 4 — Log File Analyzer (`script4_log_analyzer.sh`)
Reads a log file line by line using a `while read` loop, counts occurrences of a keyword (default: `error`), and prints a summary. Includes a do-while style retry mechanism if the log file is empty, and displays the last 5 matching lines on completion.
Concepts: `while IFS= read -r` loop, `if-then`, counter variables, command-line arguments (`$1`, `$2`), default values (`${2:-default}`), arrays, `grep -iq`, `while true + break` retry pattern, array index arithmetic.
---
Script 5 — Open Source Manifesto Generator (`script5_manifesto_generator.sh`)
Asks the user three interactive questions about their open source values, then composes a personalised philosophy statement using string concatenation and saves it to a `.txt` file named after the current user.
Concepts: `read` for interactive input, string concatenation with variables, writing to file with `>` (overwrite) and `>>` (append), `date` command, function as alias replacement, `$(whoami)`, `cat` to display output.
---
How to Run the Scripts on Linux
Prerequisites
A Linux system (Ubuntu, Fedora, Debian, CentOS, or any standard distribution)
Bash shell (pre-installed on all Linux systems)
For Script 2: VLC should be installed — see installation instructions below
Make Scripts Executable
After cloning the repository, make all scripts executable:
```bash
git clone https://github.com/avi-exe16/Open-Source-Software-Linux-Administration-audit-24BCY10407.git
cd Open-Source-Software-Linux-Administration-audit-24BCY10407
chmod +x *.sh
```
Install VLC (if not already installed)
Debian/Ubuntu:
```bash
sudo apt update && sudo apt install vlc
```
Fedora:
```bash
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install vlc
```
CentOS/RHEL:
```bash
sudo yum install epel-release
sudo yum install vlc
```
Run Script 1 — System Identity Report
```bash
./script1_system_identity.sh
```
No arguments required.
Run Script 2 — FOSS Package Inspector
```bash
./script2_foss_inspector.sh
```
No arguments required. The script auto-detects your package manager.
Run Script 3 — Disk and Permission Auditor
```bash
./script3_disk_auditor.sh
```
No arguments required. Some directory sizes may require `sudo` for accuracy.
Run Script 4 — Log File Analyzer
```bash
./script4_log_analyzer.sh /var/log/syslog error
```
Arguments:
`$1` — Path to the log file (required). Common options:
`/var/log/syslog` (Ubuntu/Debian)
`/var/log/messages` (Fedora/CentOS)
`/var/log/auth.log` (authentication log)
`$2` — Keyword to search for (optional, defaults to `error`)
More examples:
```bash
./script4_log_analyzer.sh /var/log/auth.log "Failed"
./script4_log_analyzer.sh /var/log/syslog "warning"
```
Run Script 5 — Manifesto Generator
```bash
./script5_manifesto_generator.sh
```
The script is fully interactive — it will prompt you for three answers. Your manifesto is saved to `manifesto_[yourusername].txt` in the current directory.
---
Dependencies
Script	Dependencies
Script 1	`bash`, `uname`, `whoami`, `uptime`, `date` — all standard
Script 2	`bash`, `dpkg` (Debian/Ubuntu) or `rpm` (Fedora/CentOS/RHEL)
Script 3	`bash`, `ls`, `du`, `awk`, `cut` — all standard
Script 4	`bash`, `grep` — all standard
Script 5	`bash`, `date`, `whoami`, `cat` — all standard
All dependencies are part of the standard Linux base installation. No external packages need to be installed to run the scripts.
---
Licence
This repository and its scripts are submitted as academic coursework under the VITyarthi OSS NGMC programme. The scripts are original work by the student named above.
VLC Media Player itself is licensed under GNU GPL v2, with libVLC under LGPL v2.1. More information: videolan.org
---
