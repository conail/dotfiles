sudo apt-key adv --fetch-keys http://dl.yarnpkg.com/debian/pubkey.gpg
echo "deb http://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && sudo dpkg -i erlang-solutions_1.0_all.deb
apt-key adv --keyserver keys.gnupg.net --recv-keys 09617FD37CC06B54
echo "deb https://dist.crystal-lang.org/apt crystal main" > /etc/apt/sources.list.d/crystal.list
source /etc/lsb-release && echo "deb http://download.rethinkdb.com/apt $DISTRIB_CODENAME main" | tee /etc/apt/sources.list.d/rethinkdb.list
wget -qO- https://download.rethinkdb.com/apt/pubkey.gpg | apt-key add -

apt-get -qq update && apt-get -qq dist-upgrade

# Utilities
apt-get -qq install build-essential checkinstall unattended-upgrades tree htop cmake ctags m4 

# Libraries
apt-get -qq install libbz2-dev libc6-dev libsqlite3-dev libbz2-dev libreadline-dev zlib1g-dev libncurses5-dev libssl-dev libgdbm-dev protobuf-compiler libprotobuf-dev libcurl4-openssl-dev libboost-all-dev libncurses5-dev libjemalloc-dev

# Network
apt-get -qq install netcat whois wget curl fail2ban ufw nmap nikto

# Source Control
apt-get -qq install git svn

# Editors
apt-get -qq install vim emacs23-nox dhex

# Third-party Utilities
apt-get -qq install heroku-toolbelt

# Database
apt-get -qq install postgresql postgis redis mongodb rethinkdb mysql

# Runtimes / Interpreters
git clone https://github.com/rbenv/rbenv.git $HOME/.rbenv
cd $HOME/.rbenv && src/configure && make -C src
git clone https://github.com/rbenv/ruby-build.git $HOME/.rbenv/plugins/ruby-build
wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.32.1/install.sh | bash
bash < <(curl -sSL https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
wget -O- https://toolbelt.heroku.com/install-ubuntu.sh | sh
apt-get -qq install yarn esl-erlang elixir crystal python-dev python-pip 

# Firewall
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
sed -i.bak 's/ENABLED=no/ENABLED=yes/g' /etc/ufw/ufw.conf
chmod 0644 /etc/ufw/ufw.conf

# Timezone
timedatectl set-timezone UTC

# IPFS
go get -ud github.com/ipfs/go-ipfs
cd $GOPATH/src/github.com/ipfs/go-ipfs && make install
