# Update package index, apply pending upgrades
apt-get update
apt-get -y dist-upgrade
apt-get -y autoremove

# Install Git
if [ ! -f /usr/bin/git ]; then
  apt-get install -y git
fi

# Install Node.js
if [ ! -f /usr/bin/node ]; then
  curl -sL https://deb.nodesource.com/setup | sudo bash -
  apt-get install -y nodejs
fi

# Install grunt-cli
if [ ! -f /usr/bin/grunt ]; then
  npm install -g grunt-cli
fi

# Install MongoDB
if [ ! -f /usr/bin/mongo ]; then
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
  echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.0.list
  apt-get update
  apt-get install -y mongodb-org
fi
