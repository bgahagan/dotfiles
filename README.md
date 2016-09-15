Dotfiles
========

installation
------------
```
sudo apt-get install git
git clone git://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
source "$HOME/.homesick/repos/homeshick/homeshick.sh"
homeshick cd homeshick
git checkout development
homeshick clone bgahagan/dotfiles
echo "source ~/.bashrc.common" >> ~/.bashrc
vim +PluginInstall +qall
```


Ubuntu Packages
---------------

```
sudo apt-get install \
  inotify-tools \
  silversearcher-ag
```

Also some jdk (openjdk-7-jre-headless)
