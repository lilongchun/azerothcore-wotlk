
UBUNTU_VERSION=$(lsb_release -sr);

case $UBUNTU_VERSION in
  "14.04")
    sudo apt-get -y install build-essential libtool make cmake cmake-data gcc g++ clang openssl libgoogle-perftools-dev \
    libssl-dev libmysqlclient-dev libmysql++-dev libreadline6-dev zlib1g-dev libbz2-dev libace-dev mysql-server libncurses-dev 
    ;;
  *)
    sudo apt-get install -y git cmake make gcc g++ clang libmysqlclient-dev \
    libssl-dev=1.0.2g-1ubuntu4.8 libbz2-dev libreadline-dev libncurses-dev \
    mysql-server libace-6.* libace-dev
    ;;
esac
  
