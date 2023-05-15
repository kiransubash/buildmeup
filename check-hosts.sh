#!/bin/bash

MYHOSTSFILE="openstack-hosts"

for i in `cat ${MYHOSTSFILE} | sort -r`
do
  echo -en "\033[0;32m${i}\033[0m"
  ssh ${i} "uptime" &> /dev/null && \
	  echo -e "\033[1;32m OK\033[0m" || \
	  echo -e "\033[1;31m DOWN\033[0m"
done
