# Create CentOS 6 RPM package of Python 2.7.6.
# Requires: fpm

DOWNLOAD_DIR=/tmp/fpm-python
TMP_INSTALL_DIR=/tmp/fpm-python-installdir
LATEST_PYTHON=https://www.python.org/ftp/python/2.7.12/Python-2.7.12.tgz

mkdir ${DOWNLOAD_DIR} ; mkdir ${TMP_INSTALL_DIR}
cd ${DOWNLOAD_DIR}
curl -LO ${LATEST_PYTHON} && \
  tar xf Python*.tgz && \
  cd Python*

yum -y install \
  openssl-devel \
  readline-devel \
  bzip2-devel \
  sqlite-devel \
  zlib-devel \
  ncurses-devel \
  db4-devel \
  expat-devel

# Build with shared library enabled
./configure --prefix=/usr/local --enable-shared --with-system-expat --with-system-ffi --enable-unicode=ucs4 && make

# Build with static binary (Not recommended)
# ./configure --prefix=/usr/local --with-system-expat --with-system-ffi --enable-unicode=ucs4 && make

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







