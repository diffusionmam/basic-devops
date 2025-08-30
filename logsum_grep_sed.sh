#!/bin/bash

LOGFILE="$1"

if [ -z "$LOGFILE" ]; then
    echo "Usage: $0 <logfile>"
    exit 1
fi

# Top 5 IP addresses (first field)
echo "Top 5 IP addresses with the most requests:"
grep -oE '^[^ ]+' "$LOGFILE" | sort | uniq -c | sort -rn | head -5 | sed 's/^ *\([0-9]*\) \(.*\)$/\2 - \1 requests/'
echo

# Top 5 requested paths (7th field)
echo "Top 5 most requested paths:"
sed -E 's/^([^ ]+ ){6}([^ ]+).*/\2/' "$LOGFILE" | sort | uniq -c | sort -rn | head -5 | sed 's/^ *\([0-9]*\) \(.*\)$/\2 - \1 requests/'
echo

# Top 5 response status codes (9th field)
echo "Top 5 response status codes:"
sed -E 's/^([^ ]+ ){8}([^ ]+).*/\2/' "$LOGFILE" | sort | uniq -c | sort -rn | head -5 | sed 's/^ *\([0-9]*\) \(.*\)$/\2 - \1 requests/'
echo

# Top 5 user agents (assuming user agent is the 6th quoted field)
echo "Top 5 user agents:"
sed -n 's/\([^\"]*\)"\([^\"]*\)"\([^\"]*\)"\([^\"]*\)"\([^\"]*\)"\([^\"]*\)".*/\6/p' "$LOGFILE" | sort | uniq -c | sort -rn | head -5 | sed 's/^ *\([0-9]*\) \(.*\)$/\2 - \1 requests/'
echo "-----" 