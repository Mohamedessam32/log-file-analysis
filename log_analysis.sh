#!/bin/bash

echo "===== Request Counts ====="
total=$(wc -l < access.log)
echo "Total requests:"
echo "$total"

echo "GET requests:"
grep '"GET' access.log | wc -l

echo "POST requests:"
grep '"POST' access.log | wc -l

echo ""
echo "===== Unique IP Addresses ====="
echo "Total unique IPs:"
awk '{print $1}' access.log | sort | uniq | wc -l

echo "GET and POST per IP:"
awk '{print $1, $6}' access.log | grep -E '"GET|POST' | awk '{gsub(/"/,"",$2); print $1, $2}' | sort | uniq -c | sort -nr

echo ""
echo "===== Failure Requests ====="
failures=$(awk '$9 ~ /^[45]/' access.log | wc -l)
echo "Failed requests: $failures"

if [ "$total" -ne 0 ]; then
  percent=$(awk -v f=$failures -v t=$total 'BEGIN { printf("%.2f", (f/t)*100) }')
  echo "Failure percentage: $percent%"
else
  echo "Failure percentage: N/A (no requests)"
fi

echo ""
echo "===== Most Active IP ====="
awk '{print $1}' access.log | sort | uniq -c | sort -nr | head -1

echo ""
echo "===== Daily Request Averages ====="
days=$(awk '{print $4}' access.log | cut -d: -f1 | tr -d '[' | sort | uniq | wc -l)
if [ "$days" -ne 0 ]; then
  average=$(awk -v t=$total -v d=$days 'BEGIN { printf("%.2f", t/d) }')
  echo "Average per day: $average"
else
  echo "Average per day: N/A (no date info)"
fi

echo ""
echo "===== Days with Most Failures ====="
awk '$9 ~ /^[45]/ {print $4}' access.log | cut -d: -f1 | tr -d '[' | sort | uniq -c | sort -nr

echo ""
echo "===== Requests Per Hour ====="
awk '{print $4}' access.log | cut -d: -f2 | sort | uniq -c | sort -n

echo ""
echo "===== Status Code Breakdown ====="
awk '{print $9}' access.log | sort | uniq -c | sort -nr

echo ""
echo "===== Most Active IP by Method ====="
echo "Top GET IP:"
grep '"GET' access.log | awk '{print $1}' | sort | uniq -c | sort -nr | head -1

echo "Top POST IP:"
grep '"POST' access.log | awk '{print $1}' | sort | uniq -c | sort -nr | head -1

echo ""
echo "===== Failure Patterns by Hour ====="
awk '$9 ~ /^[45]/ {print $4}' access.log | cut -d: -f2 | sort | uniq -c | sort -n

