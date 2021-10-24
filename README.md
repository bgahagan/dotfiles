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

Setup WSL
---------

On Windows:
* Install wsl
  * `wsl --install -d debian`
* (Optional) Update debian to latest version
  * update [/etc/apt/sources.list](https://salsa.debian.org/debian/WSL/-/blob/master/linux_files/sources.list)
  * `sudo apt update && sudo apt full-upgrade`
* Install [npiperelay](https://github.com/jstarks/npiperelay) to `$WIN_HOME`. See [here](https://github.com/rupor-github/wsl-ssh-agent#wsl-2-compatibility).
* Setup ssh-agent Windows service. See (here)[https://docs.microsoft.com/en-us/windows-server/administration/openssh/openssh_keymanagement]
  * `Get-Service -Name ssh-agent | Set-Service -StartupType Automatic`
  * `Start-Service ssh-agent`
  * `ssh-add <key_file>`
