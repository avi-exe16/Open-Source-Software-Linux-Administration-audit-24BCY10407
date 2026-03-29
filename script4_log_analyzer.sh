#!/bin/bash
# ============================================================
# Script 4: Log File Analyzer
# Author:   Abhishek Shandilya
# Course:   Open Source Software Linux Administration
# Purpose:  Read a log file line-by-line, count occurrences
#           of a keyword, and print a summary with matching
#           lines. Supports retry if the file is empty.
# Usage:    ./script4_log_analyzer.sh /var/log/syslog [keyword]
#           Example: ./script4_log_analyzer.sh /var/log/syslog error
# ============================================================

# --- Command-line arguments ---
# $1 = log file path (required)
# $2 = keyword to search (optional, defaults to "error")
LOGFILE=$1
KEYWORD=${2:-"error"}    # If no second argument given, default to "error"

# --- Counter variable for matching lines ---
COUNT=0

# --- Matching lines collector ---
MATCHED_LINES=()

echo "================================================================"
echo "       LOG FILE ANALYZER"
echo "================================================================"
echo ""

# --- Validate that an argument was provided ---
if [ -z "$LOGFILE" ]; then
    echo "  Usage: $0 <log_file_path> [keyword]"
    echo "  Example: $0 /var/log/syslog error"
    echo ""
    echo "  Common log files to try:"
    echo "    /var/log/syslog     (Ubuntu/Debian)"
    echo "    /var/log/messages   (Fedora/CentOS)"
    echo "    /var/log/auth.log   (authentication events)"
    exit 1
fi

# --- Check if the file exists ---
if [ ! -f "$LOGFILE" ]; then
    echo "  ERROR: File '$LOGFILE' not found."
    echo "  Please provide a valid log file path."
    exit 1
fi

echo "  Log file  : $LOGFILE"
echo "  Keyword   : '$KEYWORD'  (case-insensitive search)"
echo ""

# --- Retry mechanism if file is empty ---
# This demonstrates a do-while style loop in bash using while true + break
RETRY_COUNT=0
MAX_RETRIES=3

while true; do
    # Check if the file has any content
    if [ -s "$LOGFILE" ]; then
        # File is non-empty, proceed with analysis
        break
    else
        RETRY_COUNT=$((RETRY_COUNT + 1))
        echo "  WARNING: '$LOGFILE' appears to be empty. (Attempt $RETRY_COUNT of $MAX_RETRIES)"

        if [ $RETRY_COUNT -ge $MAX_RETRIES ]; then
            echo "  File remains empty after $MAX_RETRIES checks. Exiting."
            exit 1
        fi

        # Wait 2 seconds before retrying (simulates waiting for log activity)
        sleep 2
    fi
done

echo "  Reading log file..."
echo "  -------------------------------------------------------"

# --- Main while-read loop: process the file line by line ---
# IFS= prevents leading/trailing whitespace from being stripped
# -r prevents backslash interpretation
while IFS= read -r LINE; do

    # if-then: check if this line contains the keyword (case-insensitive)
    if echo "$LINE" | grep -iq "$KEYWORD"; then
        COUNT=$((COUNT + 1))                  # Increment counter
        MATCHED_LINES+=("$LINE")             # Append line to array
    fi

done < "$LOGFILE"     # Redirect file into the while loop as input

echo ""
echo "  --- Analysis Complete ---"
echo ""

# --- Print summary ---
echo "  Keyword  : '$KEYWORD'"
echo "  Log file : $LOGFILE"
echo "  Matches  : $COUNT line(s) found"
echo ""

# --- Show last 5 matching lines if any were found ---
if [ $COUNT -gt 0 ]; then
    echo "  --- Last 5 Matching Lines ---"
    echo "  -------------------------------------------------------"

    # Calculate starting index to show last 5 entries
    TOTAL=${#MATCHED_LINES[@]}
    START=$(( TOTAL > 5 ? TOTAL - 5 : 0 ))

    # Loop through the last (up to) 5 matched lines
    for (( i=START; i<TOTAL; i++ )); do
        echo "  > ${MATCHED_LINES[$i]}"
    done

    echo ""
    echo "  Tip: To see all matches, run:"
    echo "    grep -i '$KEYWORD' $LOGFILE"
else
    echo "  No lines matching '$KEYWORD' were found in this log file."
    echo "  Try a different keyword or log file."
fi

echo ""
echo "================================================================"
echo "  Shell scripting concepts used: command-line arguments (\$1 \$2),"
echo "  default values (\${2:-default}), if-then, while-read loop,"
echo "  do-while retry pattern (while true + break), counter variable,"
echo "  arrays, IFS= for safe line reading, grep -iq for case-insensitive"
echo "  search, array index arithmetic for last-5 display."
echo "================================================================"
