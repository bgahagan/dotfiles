Dotfiles
========

Initial setup
-------------

```
sudo apt install -y curl wget git
bash <(curl -sSf https://raw.githubusercontent.com/bgahagan/dotfiles/master/home/bin/setup-my-env.sh) vim
```

Then install additional apps with `setup-my-env.sh <app>`

GPG Agent
---------

Setup [GnuPGP agent forwarding](https://wiki.gnupg.org/AgentForwarding) on ssh target machines
```
echo "StreamLocalBindUnlink yes" | sudo tee -a /etc/ssh/sshd_config
```

