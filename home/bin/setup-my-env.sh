#!/bin/bash

set -eu -o pipefail


base_setup() {
  for app in git wget curl; do
    if ! type $app 2>/dev/null ; then
      echo "$app not installed; aborting"
      exit 1
    fi
  done

  if ! [ -d $HOME/.homesick/repos/homeshick ]; then
    echo "Installing homeshick"
    git clone git://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
  fi
  source "$HOME/.homesick/repos/homeshick/homeshick.sh"

  if ! grep -q "source ~/.bashrc.common" ~/.bashrc ; then
    echo "Installing dotfiles"
    homeshick -b clone bgahagan/dotfiles
    homeshick -b link dotfiles
    echo "source ~/.bashrc.common" >> ~/.bashrc
  fi

  if ! type inotifywatch 2>/dev/null ; then
    sudo apt install -y inotify-tools
  fi

  if ! type ag 2>/dev/null ; then
    sudo apt install -y silversearcher-ag
  fi

  if ! type gpg 2>/dev/null ; then
    sudo apt install -y gpg
    curl -sSf https://gahagan.ca/bgahagan.gpg | gpg --import
    ## Trust the imported key
    echo -e "trust\n5\ny\nquit" | gpg --command-fd 0 --edit-key 9E8C0FEC3789E6F3CF4B8FD96FFAF1538F282F76
  fi
}

install_vim() {
  if ! type vim 2>/dev/null ; then
    sudo apt install -y vim
  fi

  echo "Installing vim plugins"
  vim +PluginInstall +qall

  if ! type fzf 2>/dev/null ; then 
    $HOME/.vim/bundle/fzf/install --all --key-bindings --completion --update-rc --no-zsh --no-fish
  fi
}

install_git_remote_s3() {
  if ! type git-remote-s3 2>/dev/null ; then 
    echo "Installing git-remote-s3"
    wget 'https://github.com/bgahagan/git-remote-s3/releases/download/v0.1.2/git-remote-s3-x86_64-unknown-linux-gnu.gz' -O /tmp/git-remote-s3.gz
    gunzip /tmp/git-remote-s3.gz
    mv /tmp/git-remote-s3 ~/bin/git-remote-s3
    chmod u+x ~/bin/git-remote-s3
  fi
}

install_docker() {
  if ! type docker 2>/dev/null ; then 
    echo "Installing docker"
    sudo apt install -y docker.io
  fi
  if ! [ -e ~/bin/docker-compose ] ; then
    echo "Installing docker-compose"
    wget https://github.com/docker/compose/releases/download/1.25.0/docker-compose-`uname -s`-`uname -m` -O ~/bin/docker-compose
    chmod u+x ~/bin/docker-compose
  fi
}

install_hub() {
  if ! type hub 2>/dev/null ; then 
    echo "Installing hub"
    wget 'https://github.com/github/hub/releases/download/v2.13.0/hub-linux-arm64-2.13.0.tgz' -O /tmp/hub.gz
    gunzip /tmp/hub.gz
    mv /tmp/hub ~/bin/hub
    chmod u+x ~/bin/hub
  fi
}

install_node() {
  if ! type n 2>/dev/null ; then 
    echo "Installing n (node version manager)"
    curl -sSf -L https://git.io/n-install | bash -s -- latest
  fi
}

install_rust() {
  if ! type rustup 2>/dev/null ; then 
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  fi
}

install_go() {
  if ! type go 2>/dev/null ; then 
    sudo add-apt-repository ppa:longsleep/golang-backports
    sudo apt-get update
    sudo apt-get install golang-go
  fi
}

install_tmux() {
  if ! type tmux 2>/dev/null ; then
    sudo apt install -y tmux
    ~/.tmux/plugins/tpm/bin/install_plugins
  fi
}

list_apps() {
  compgen -A function install_ | sed 's/install_//'
}

if (( $# == 0 )) ; then
  echo "Must specify an app to install."
  echo "Available apps (or use 'all'):"
  list_apps | sed 's/^/  - /'
  exit 1
fi

base_setup
for app in "$@"; do
  if [ "$app" == "all" ] ; then
    apps=( $(list_apps) )
    for app in "${apps[@]}"; do
      install_$app
    done
  else 
    install_$app
  fi
done

echo "All done, run the following in this shell, or start a new shell: "
echo "  source ~/.bashrc.common"

