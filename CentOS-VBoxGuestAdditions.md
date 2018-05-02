Update kernel and Install required dependencies
```
yum update kernel*
yum install gcc kernel-devel kernel-headers dkms make bzip2 perl
```

Export `KERN_DIR` to point to the right path for your install
```
KERN_DIR=/usr/src/kernels/`uname -r`/build
export KERN_DIR
```

Mount the media and run the Installer
```
mount /dev/sr0 /media
cd /media
./VBoxLinuxAdditions.run
```

After succesful completion, reboot
```
reboot
```
