Dotfiles
========

installation
------------

Ubuntu Packages
```
sudo apt install \
  git \
  tmux \
  inotify-tools \
  silversearcher-ag
```

Dotfiles
```
git clone git://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
source "$HOME/.homesick/repos/homeshick/homeshick.sh"
homeshick clone bgahagan/dotfiles
echo "source ~/.bashrc.common" >> ~/.bashrc
vim +PluginInstall +qall
source ~/.bashrc.common
```

Setup [GnuPGP agent forwarding](https://wiki.gnupg.org/AgentForwarding)
```
echo "StreamLocalBindUnlink yes" | sudo tee -a /etc/ssh/sshd_config
```

