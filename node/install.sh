if test ! $(which node -v)
then
  sudo n latest
fi

if test ! $(which spoof)
then
  sudo npm install spoof -g
fi
