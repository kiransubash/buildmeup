#!/bin/bash

# Something I used to clean up VM bridges and set all VMs to have the same BR0 bridge interface. 

for instance in `virsh list --all | grep instance | awk {'print $2'}`
do
  for mac in `virsh dumpxml ${instance} | grep -i bridge -A5 | grep mac | awk -F "'" {'print $2'} `
  do 
    echo "Removing interface ${mac} from ${instance}"
    virsh detach-interface ${instance} --type bridge --mac ${mac} --persistent
  done
  echo -n "Waiting for sync..."
  sleep 5
  echo "done"
  echo "Attaching bridge br0 to instance ${instance}"
  virsh attach-interface ${instance} --type bridge --source br0 --persistent --model virtio
  echo "Instance $instance : "
  virsh dumpxml ${instance} | grep -i bridge -A5
  echo
done
