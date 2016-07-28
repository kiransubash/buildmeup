# Create CentOS 6 RPM package of Python 2.7.6.
# Requires: fpm

mkdir /tmp/fpm-python ; mkdir /tmp/fpm-python-installdir
cd /tmp/fpm-python
curl -LO http://python.org/ftp/python/2.7.6/Python-2.7.6.tgz && \
  tar xf Python-2.7.6.tgz && \
  cd Python-2.7.6

yum -y install \
  openssl-devel \
  readline-devel \
  bzip2-devel \
  sqlite-devel \
  zlib-devel \
  ncurses-devel \
  db4-devel \
  expat-devel

./configure --prefix=/usr/local --enable-unicode=ucs4 --enable-shared --enable-ipv6



