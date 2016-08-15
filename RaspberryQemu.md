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

## Get the Image file
#### Raspbian
Download from https://www.raspberrypi.org/downloads/raspbian/

##### Minimal image 
~~~~
kiran-subash:~ kiran.subash$ curl -LO https://downloads.raspberrypi.org/raspbian_lite_latest
~~~~
