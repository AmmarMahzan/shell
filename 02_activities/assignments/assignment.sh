#!/bin/bash
set -euo pipefail
set -x

############################################
# DSI CONSULTING INC. Project setup script #
############################################
# This script creates standard analysis and output directories
# for a new project. It also creates a README file with the
# project name and a brief description of the project.
# Then it unzips the raw data provided by the client.

mkdir -p analysis output
touch README.md
mkdir -p analysis
touch analysis/main.py

# download client data
curl -Lo rawdata.zip https://github.com/UofT-DSI/shell/raw/refs/heads/main/02_activities/assignments/rawdata.zip
unzip -q rawdata.zip

###########################################
# Complete assignment here

# 1. Create a directory named data and move contents of rawdata into it
dmkdir -p data/raw
# Move all rawdata files into data/raw and remove the now-empty rawdata folder
mv rawdata/* data/raw/
rmdir rawdata

# 2. List the contents of the ./data/raw directory
echo "Contents of data/raw:"
ls data/raw

# 3. In ./data/processed, create the following directories:
mkdir -p data/processed/server_logs data/processed/user_logs data/processed/event_logs

# 4. Copy all server log files from ./data/raw to ./data/processed/server_logs
find data/raw -type f -name "*server*.log" -exec cp {} data/processed/server_logs/ \;

# 5. Copy all user log files to ./data/processed/user_logs
find data/raw -type f -name "*user*.log" -exec cp {} data/processed/user_logs/ \;

# 6. Copy all event log files to ./data/processed/event_logs
find data/raw -type f -name "*event*.log" -exec cp {} data/processed/event_logs/ \;

# 7. Remove files containing "ipaddr" for user privacy
find data/raw               -type f -name "*ipaddr*" -delete
find data/processed/user_logs -type f -name "*ipaddr*" -delete

# 8. Create a file named ./data/inventory.txt listing all files in data/processed
find data/processed -type f > data/inventory.txt

###########################################

echo "Project setup is complete!"
