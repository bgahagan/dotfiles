#!/bin/bash

set -eu -o pipefail

install_package() {

  local -a POSITIONAL
  local key
  local apt_package
  local fii=false

  while [[ $# -gt 0 ]]; do
    key="$1"

    case $key in
      -f|--fail-if-installed)
        fii=true
        shift # past argument
        ;;
      -a|--apt)
        apt_package="$2"
        shift # past argument
        shift # past value
        ;;
      -p|--pacman)
        pacman_package="$2"
        shift # past argument
        shift # past value
        ;;
      *)    # unknown option
        POSITIONAL+=("$1") # save it in an array for later
        shift # past argument
        ;;
    esac
  done
  set -- "${POSITIONAL[@]}" # restore positional parameters

  local executable=$1

  if ! type $executable &>/dev/null ; then
    echo "Intalling $executable"
    if type apt &>/dev/null ; then
      sudo apt install -y ${apt_package:-$executable}
    elif type pacman &>/dev/null ; then
      sudo pacman --noconfirm -S ${pacman_package:-$executable}
    fi
    if ! type $executable &>/dev/null ; then
      echo "ERROR: $executable: could not intall"
      return 1
    fi
  else
    if [ "$fii" = "true" ]; then
      # Fail becuase the program was already installed
      return 1
    fi
  fi
}

base_setup() {

  install_package git
  install_package wget
  install_package curl
  install_package file

  if ! [ -d $HOME/.homesick/repos/homeshick ]; then
    echo "Installing homeshick"
    git clone https://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
  fi
  source "$HOME/.homesick/repos/homeshick/homeshick.sh"

  if ! grep -q "source ~/.bashrc.common" ~/.bashrc ; then
    echo "Installing dotfiles"
    homeshick -b clone bgahagan/dotfiles
    homeshick -b link dotfiles
    echo "source ~/.bashrc.common" >> ~/.bashrc
  fi

  install_package inotifywatch --apt inotify-tools --pacman inotify-tools || true
  install_package ag --apt silversearcher-ag --pacman the_silver_searcher|| true
  install_package socat || true

}

install_ssh_authorized_keys() {
  if ! grep -q bgahagan ~/.ssh/authorized_keys > /dev/null ; then
    mkdir -p ~/.ssh
    curl -sSf https://gahagan.ca/bgahagan_authorized_keys >> ~/.ssh/authorized_keys
  fi
}

install_gpg() {
  if install_package gpg; then
    if ! gpg -k bgahagan >/dev/null ; then
      curl -sSf https://gahagan.ca/bgahagan.gpg | gpg --import
      ## Trust the imported key
      echo -e "trust\n5\ny\nquit" | gpg --command-fd 0 --edit-key 9E8C0FEC3789E6F3CF4B8FD96FFAF1538F282F76
    fi
  fi
}

install_vim() {
  install_package vim

  echo "Installing vim plugins"
  vim +PluginInstall +qall

  if ! type fzf &>/dev/null ; then 
    $HOME/.vim/bundle/fzf/install --all --key-bindings --completion --update-rc --no-zsh --no-fish
  fi
}

install_git_remote_s3() {
  if ! type git-remote-s3 &>/dev/null ; then 
    echo "Installing git-remote-s3"
    wget 'https://github.com/bgahagan/git-remote-s3/releases/download/v0.1.2/git-remote-s3-x86_64-unknown-linux-gnu.gz' -O /tmp/git-remote-s3.gz
    gunzip /tmp/git-remote-s3.gz
    mv /tmp/git-remote-s3 ~/bin/git-remote-s3
    chmod u+x ~/bin/git-remote-s3
  fi
}

install_docker() {
  if ! type docker &>/dev/null ; then 
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
  if ! type hub &>/dev/null ; then 
    echo "Installing hub"
    wget 'https://github.com/github/hub/releases/download/v2.13.0/hub-linux-arm64-2.13.0.tgz' -O /tmp/hub.gz
    gunzip /tmp/hub.gz
    mv /tmp/hub ~/bin/hub
    chmod u+x ~/bin/hub
  fi
}

install_gh() {
  if ! type gh &>/dev/null ; then 
    echo "Installing gh"
    wget 'https://github.com/cli/cli/releases/download/v2.21.2/gh_2.21.2_linux_amd64.tar.gz' -O /tmp/gh.tgz
    mkdir /tmp/gh
    cd /tmp/gh
    tar -xvf /tmp/gh.tgz
    mv /tmp/gh/gh*/bin/gh ~/bin/gh
    chmod u+x ~/bin/gh
    rm /tmp/gh.tgz
    rm -r /tmp/gh
  fi
}

install_node() {
  install_package make || true
  if ! type n &>/dev/null ; then 
    echo "Installing n (node version manager)"
    curl -sSf -L https://git.io/n-install | bash -s -- latest
  fi
}

install_rust() {
  if ! type rustup &>/dev/null ; then 
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  fi
}

install_go() {
  if ! type go &>/dev/null ; then 
    sudo add-apt-repository ppa:longsleep/golang-backports
    sudo apt-get update
    sudo apt-get install golang-go
  fi
}

install_tmux() {
  install_package tmux
  ~/.tmux/plugins/tpm/bin/install_plugins
}

install_ssh_agent_auth() {
  if ! [ -f /etc/sudoers.d/00_SSH_AGENT_AUTH ]; then
    install_package libpam-ssh-agent-auth || true
    echo "Defaults env_keep += SSH_AUTH_SOCK" | sudo tee /etc/sudoers.d/00_SSH_AGENT_AUTH
    sudo chmod 0440 /etc/sudoers.d/00_SSH_AGENT_AUTH
    sudo sed -i.ssh_agent_auth_bak -e 's|@include common-auth|auth sufficient pam_ssh_agent_auth.so file=~/.ssh/authorized_keys\n\0|' /etc/pam.d/sudo
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

