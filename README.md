Dotfiles
========

installation
------------
<code>
  sudo apt-get install git
  git clone git://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
  source "$HOME/.homesick/repos/homeshick/homeshick.sh"
  homeshick cd homeshick
  git co development
  homeshick clone bgahagan/dotfiles
  echo "source ~/.bashrc.common" >> ~/.bashrc
</code>

Ubuntu Packages
---------------

<code>
  sudo apt-get install \
    inotify-tools
    silversearcher-ag

</code>

Also some jdk (openjdk-7-jre-headless)
