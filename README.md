
# Log File Analysis with Bash

This project performs an analysis of a sample Apache-style access log file using a Bash script.

## 🔍 Objective

The script provides insights such as:
- Total number of requests
- GET and POST request counts
- Unique IP address statistics
- Failure analysis (4xx/5xx status codes)
- Most active IP addresses
- Daily averages
- Status code breakdown
- Request trends by hour
- Most active users by method
- Failure patterns

## 📁 Files

- `access.log` — sample log file used for analysis.
- `log_analysis.sh` — main Bash script that processes the log.
- `report.txt` — output of the script containing full analysis results.

## 🚀 How to Use

```bash
chmod +x log_analysis.sh
./log_analysis.sh > report.txt
