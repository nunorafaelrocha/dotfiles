
# For linux Yarn is installed via apt-get (linux/install-software.sh).
if [ `uname` == "Darwin" ]; then
  # This cannot be installed via brew because it install node and npm.
  if test ! $(which yarn -v); then
    curl -o- -L https://yarnpkg.com/install.sh | bash -s -- --rc
  fi
fi
