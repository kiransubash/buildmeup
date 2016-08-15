#Raspberry Pi Emulator with Qemu
A brief guide to get a Raspberry Pi emulator on your favorite OS

## Installing QEMU for your OS

### Linux 

CentOS/RHEL/Fedora
~~~~
yum install qemu
~~~~

Debian/Ubuntu

~~~~
apt-get install qemu qemu-kvm libvirt-bin
~~~~

### Mac
Brew provides qemu out of the box. 

~~~~
kiran-subash:~ kiran.subash$ brew info qemu
qemu: stable 2.6.0 (bottled), HEAD
x86 and PowerPC Emulator
http://wiki.qemu.org
/usr/local/Cellar/qemu/2.5.0_2 (125 files, 118.3M) *
  Poured from bottle on 2016-02-24 at 08:51:51
From: https://github.com/Homebrew/homebrew-core/blob/master/Formula/qemu.rb
==> Dependencies
Build: pkg-config ✔, libtool ✔
Required: jpeg ✔, gnutls ✘, glib ✔, pixman ✔
Recommended: libpng ✔
Optional: vde ✘, sdl ✘, gtk+ ✘, libssh2 ✘
==> Options
--with-gtk+
	Build with gtk+ support
--with-libssh2
	Build with libssh2 support
--with-sdl
	Build with sdl support
--with-vde
	Build with vde support
--without-libpng
	Build without libpng support
--HEAD
	Install HEAD version
~~~~

## Build a Kernel image

TODO

## Get the Image file
#### Raspbian
Download from https://www.raspberrypi.org/downloads/raspbian/

##### Minimal image 
~~~~
kiran-subash:~ kiran.subash$ curl -LO https://downloads.raspberrypi.org/raspbian_lite_latest
~~~~

Unzip the archive to extract the ```img``` file. 

~~~~
kiran-subash:~ kiran.subash$ ls -lrth 2016-05-27-raspbian-jessie-lite.img
-rw-r--r--  1 kiran.subash  1365734164   1.3G May 27 17:11 2016-05-27-raspbian-jessie-lite.img
~~~~

## Running QEMU
~~~~
qemu-system-arm.exe -M versatilepb -cpu arm1176 -m 256 -hda 2016-05-27-raspbian-jessie-lite.img -kernel  ~/Downloads/zImage_3.1.9 -append "root=/dev/sda2" -net nic -net user,hostfwd=tcp::2222-:22
~~~~
