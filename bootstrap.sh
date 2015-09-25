export DEBIAN_FRONTEND=noninteractive
export DISTRO=$(lsb_release -c -s)

# setup locate properly
if ! cat /etc/default/locale | grep LC_ALL > /dev/null; then
  printf 'LANG="en_US.UTF-8"\nLC_ALL="en_US.UTF-8"\nLC_CTYPE="en_US.UTF-8"\nLANGUAGE="en_US.UTF-8"' > /etc/default/locale
  . /etc/default/locale
  dpkg-reconfigure locales
fi

# Update package index, apply pending upgrades
apt-get update
apt-get -y dist-upgrade
apt-get -y autoremove

# Install Git
if [ ! -f /usr/bin/git ]; then
  apt-get install -y git
fi

# Curl
if [ ! -f /usr/bin/curl ]; then
  apt-get install curl
fi

# Build essential
if [ ! -f /usr/bin/g++ ]; then
  apt-get install -y build-essential
fi

# Install Node.js
if [ ! -f /usr/bin/node ]; then
  curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -
  echo "deb http://deb.nodesource.com/node_4.x ${DISTRO} main" > /etc/apt/sources.list.d/nodesource.list
  echo "deb-src http://deb.nodesource.com/node_4.x ${DISTRO} main" >> /etc/apt/sources.list.d/nodesource.list
  apt-get update && apt-get install -y nodejs
fi

# Install MongoDB
if [ ! -f /usr/bin/mongo ]; then
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
  echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.0.list
  apt-get update
  apt-get install -y mongodb-org
fi
