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

# 1. Create a directory named data and move rawdata into data/raw
mkdir -p data/raw
mv rawdata data/raw

# 2. List the contents of the ./data/raw directory
echo "Contents of data/raw:"
ls data/raw

# 3. In ./data/processed, create the following directories: server_logs, user_logs, and event_logs
mkdir -p data/processed/{server_logs,user_logs,event_logs}

# 4. Copy all server log files ("server" in name, .log extension) from raw to processed/server_logs
find data/raw -maxdepth 1 -type f -name "*server*.log" -exec cp {} data/processed/server_logs/ \;

# 5. Copy all user log files to processed/user_logs
find data/raw -maxdepth 1 -type f -name "*user*.log" -exec cp {} data/processed/user_logs/ \;

# 6. Copy all event log files to processed/event_logs
find data/raw -maxdepth 1 -type f -name "*event*.log" -exec cp {} data/processed/event_logs/ \;

# 7. Remove files containing "ipaddr" from raw and processed/user_logs
find data/raw -type f -name "*ipaddr*" -delete
find data/processed/user_logs -type f -name "*ipaddr*" -delete

# 8. Create inventory of all files in subfolders of processed
find data/processed -type f > data/inventory.txt

###########################################

echo "Project setup is complete!"
# 8. Create a file named ./data/inventory.txt that lists all the files in the subfolders of ./data/processed


###########################################

echo "Project setup is complete!"
