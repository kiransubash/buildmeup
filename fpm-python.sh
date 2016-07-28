# Create CentOS 6 RPM package of Python 2.7.12
# Requires: fpm

DOWNLOAD_DIR=/tmp/fpm-python
TMP_INSTALL_DIR=/tmp/fpm-python-installdir
LATEST_PYTHON=https://www.python.org/ftp/python/2.7.12/Python-2.7.12.tgz
VERSION="2.7.12"

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

# Add /usr/local/lib to ldconfig path if not exists - not required for static linked build ; create symlink to binary
cat << EOF > ${TMP_INSTALL_DIR}/post-install.sh
echo "/usr/local/lib" > /etc/ld.so.conf.d/python2.7.conf && /sbin/ldconfig
ln -s /usr/local/bin/python2.7 /usr/bin/python2.7
EOF

# Remove our addition of ldconfig library path, and symlink
cat << EOF > ${TMP_INSTALL_DIR}/post-uninstall.sh
/bin/rm /etc/ld.so.conf.d/python2.7.conf && /sbin/ldconfig
/bin/rm /usr/bin/python2.7
EOF

fpm -s dir -t rpm -n python27 -v ${VERSION} -C ${TMP_INSTALL_DIR} \
  --after-install ${TMP_INSTALL_DIR}/post-install.sh \
  --after-remove ${TMP_INSTALL_DIR}/post-uninstall.sh \
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

/bin/rm -fr ${TMP_INSTALL_DIR} ${DOWNLOAD_DIR}
