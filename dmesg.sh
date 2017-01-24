#!/bin/sh
# Simple snippet to print timestamps with dmesg output
# highly useful on long lived machines
# 
base=$(cut -d '.' -f1 /proc/uptime);
seconds=$(date +%s);
dmesg | sed 's/\]//;s/\[//;s/\([^.]\)\.\([^ ]*\)\(.*\)/\1\n\3/' |
while read first; do
  read second;
  first=`date +"%d/%m/%Y %H:%M:%S" --date="@$(($seconds - $base + $first))"`;
  printf "[%s] %s\n" "$first" "$second";
done
