# Create CentOS 6 RPM package of Python 2.7.6.
# Requires: fpm

DOWNLOAD_DIR=/tmp/fpm-python
TMP_INSTALL_DIR=/tmp/fpm-python-installdir

mkdir ${DOWNLOAD_DIR} ; mkdir ${TMP_INSTALL_DIR}
cd ${DOWNLOAD_DIR}
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

./configure --prefix=/usr/local --enable-unicode=ucs4 --enable-shared --enable-ipv6 && make

make install DESTDIR=${TMP_INSTALL_DIR}

echo '/sbin/ldconfig' > ${TMP_INSTALL_DIR}/run-ldconfig.sh

fpm -s dir -t rpm -n python27 -v 2.7.6 -C ${TMP_INSTALL_DIR} \
  --after-install ${TMP_INSTALL_DIR}/run-ldconfig.sh \
  -d 'openssl' \
  -d 'bzip2' \
  -d 'zlib' \
  -d 'expat' \
  -d 'db4' \
  -d 'sqlite' \
  -d 'ncurses' \
  -d 'readline' \
  --directories=/usr/local/lib/python2.7/ \
  --directories=/usr/local/include/python2.7/ \
  usr/local







