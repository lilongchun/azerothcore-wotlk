
UBUNTU_VERSION=$(lsb_release -sr);

if [[ $TRAVIS && $CONTINUOUS_INTEGRATION ]]; then
  sudo apt-get -y install build-essential libtool make cmake cmake-data openssl libgoogle-perftools-dev \
  libssl-dev libmysqlclient-dev libmysql++-dev libreadline6-dev zlib1g-dev libbz2-dev libace-dev
  wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | sudo apt-key add -
  sudo apt-add-repository "deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial-6.0 main"
  sudo apt-get update
  sudo apt-get install -y clang-6.0
else
  case $UBUNTU_VERSION in
    "14.04")
      sudo apt-get -y install build-essential libtool make cmake cmake-data gcc g++ clang openssl libgoogle-perftools-dev \
      libssl-dev libmysqlclient-dev libmysql++-dev libreadline6-dev zlib1g-dev libbz2-dev libace-dev mysql-server libncurses-dev \
      curl unzip
      ;;
    *)
      sudo apt-get install -y git cmake make gcc g++ clang libmysqlclient-dev \
      libssl-dev libbz2-dev libreadline-dev libncurses-dev \
      mysql-server libace-6.* libace-dev curl unzip
      ;;
  esac
fi
  
