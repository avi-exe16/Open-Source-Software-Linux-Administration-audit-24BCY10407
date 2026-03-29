#!/bin/bash
# ============================================================
# Script 5: Open Source Manifesto Generator
# Author:   Abhishek Shandilya
# Course:   Open Source Software Linux Administration
# Purpose:  Interactively ask the user three questions, then
#           compose a personalised open source philosophy
#           statement and save it to a .txt file.
# Usage:    ./script5_manifesto_generator.sh
# ============================================================

# --- Alias concept demonstrated via a comment and function ---
# In a real shell session, you might define:
#   alias today='date +%d\ %B\ %Y'
# Here we replicate that with a function for portability inside a script

get_today() {
    date '+%d %B %Y'    # Returns e.g. "29 March 2026"
}

# ─── Introduction Banner ─────────────────────────────────────────────────────

echo "================================================================"
echo "       OPEN SOURCE MANIFESTO GENERATOR"
echo "       VLC Audit — OSS NGMC Capstone Project"
echo "================================================================"
echo ""
echo "  Answer three questions and I will compose your personal"
echo "  open source philosophy statement and save it as a .txt file."
echo ""
echo "----------------------------------------------------------------"
echo ""

# ─── Interactive Questions using 'read' ──────────────────────────────────────

# Question 1: A real tool the user uses
read -p "  1. Name one open-source tool you use every day: " TOOL

# Question 2: What freedom means to them, in one word
read -p "  2. In one word, what does 'freedom' mean to you? " FREEDOM

# Question 3: Something they would build and share freely
read -p "  3. Name one thing you would build and share freely: " BUILD

# ─── Collect Metadata ────────────────────────────────────────────────────────

DATE=$(get_today)                           # Today's date via our alias-style function
USER_ID=$(whoami)                           # The person running this script
OUTPUT="manifesto_${USER_ID}.txt"          # Output filename includes the username

# ─── Compose the Manifesto ───────────────────────────────────────────────────
# String concatenation is done by writing adjacent variables and text
# The >> operator appends to a file; > would overwrite it

# Clear the output file if it already exists, then write fresh content
> "$OUTPUT"

# Write the manifesto header to the file
echo "================================================================" >> "$OUTPUT"
echo "  OPEN SOURCE MANIFESTO" >> "$OUTPUT"
echo "  Generated on : $DATE" >> "$OUTPUT"
echo "  Author       : $USER_ID" >> "$OUTPUT"
echo "================================================================" >> "$OUTPUT"
echo "" >> "$OUTPUT"

# Write the personalised manifesto paragraph using string concatenation
# Each echo >> adds one line; together they form the full paragraph
echo "  I believe in software that serves people, not profits." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "  Every day I rely on $TOOL — a tool built by people who chose" >> "$OUTPUT"
echo "  to share their work rather than lock it away. That choice made" >> "$OUTPUT"
echo "  my work possible. It made countless others' work possible too." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "  To me, freedom means $FREEDOM. In the context of software," >> "$OUTPUT"
echo "  freedom means the right to read the code, to understand it," >> "$OUTPUT"
echo "  to change it, and to pass it on. A program you cannot inspect" >> "$OUTPUT"
echo "  is a black box you are forced to trust. That is not freedom." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "  If I could build and share one thing freely with the world," >> "$OUTPUT"
echo "  it would be $BUILD. I would release it under an open licence" >> "$OUTPUT"
echo "  because I know that the best things I use today — the tools," >> "$OUTPUT"
echo "  the platforms, the languages — came to me the same way." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "  Open source is not just a licensing model. It is a belief" >> "$OUTPUT"
echo "  that knowledge shared is knowledge multiplied. Every line of" >> "$OUTPUT"
echo "  code released to the world is a small act of trust in the" >> "$OUTPUT"
echo "  people who will read it, use it, and build something better." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "  This is my manifesto." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "  -- $USER_ID, $DATE" >> "$OUTPUT"
echo "================================================================" >> "$OUTPUT"

# ─── Display Result ──────────────────────────────────────────────────────────

echo ""
echo "----------------------------------------------------------------"
echo "  Manifesto generated and saved to: $OUTPUT"
echo "----------------------------------------------------------------"
echo ""

# Display the saved file content using cat
cat "$OUTPUT"

echo ""
echo "================================================================"
echo "  Shell scripting concepts used: read for interactive input,"
echo "  string concatenation with variables inline, writing to a file"
echo "  with > (overwrite) and >> (append), date command, function"
echo "  as alias replacement, \$(whoami) command substitution,"
echo "  cat to display file output."
echo "================================================================"
