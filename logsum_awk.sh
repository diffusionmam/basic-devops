#!/bin/bash

LOGFILE="$1"

if [ -z "$LOGFILE" ]; then
    echo "Usage: $0 <logfile>"
    exit 1
fi

# Top 5 IP addresses (reverse numeric sort)
awk '{ip[$1]++} END {for (i in ip) print ip[i], i | "sort -rn | head -5"}' "$LOGFILE" | \
awk 'BEGIN{print "Top 5 IP addresses with the most requests:"} {print $2 " - " $1 " requests"}'
echo

# Top 5 requested paths (assuming path is the 7th field in common log format)
awk '{path[$7]++} END {for (p in path) print path[p], p | "sort -rn | head -5"}' "$LOGFILE" | \
awk 'BEGIN{print "Top 5 most requested paths:"} {print $2 " - " $1 " requests"}'
echo

# Top 5 response status codes (assuming status code is the 9th field)
awk '{code[$9]++} END {for (c in code) print code[c], c | "sort -rn | head -5"}' "$LOGFILE" | \
awk 'BEGIN{print "Top 5 response status codes:"} {print $2 " - " $1 " requests"}'
echo

# Top 5 user agents (assuming user agent is everything after the 12th field, in quotes)
awk -F'"' '{ua[$6]++} END {for (u in ua) print ua[u], u | "sort -rn | head -5"}' "$LOGFILE" | \
awk 'BEGIN{print "Top 5 user agents:"} {print $2 " - " $1 " requests"}'
echo "-----" 

# Conclusion, awk is faster than sed and grep for this use case (field based aggregation)