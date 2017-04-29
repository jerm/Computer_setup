#!/bin/bash

echo -n "Computer name? (enter to skip): "
read hname
if [ -n "$hname" ]; then
	sudo scutil --set ComputerName "$hname"
	sudo scutil --set HostName "$hname"
	sudo scutil --set LocalHostName "$hname"
fi 

echo -n "run osx hacks? [y/N]:"
read hacks

install_homebrew(){
    [ -e /usr/local/bin/brew ] || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    #brew doctor
}

sudo easy_install pip
install_homebrew
brew install ansible


#sudo ARCHFLAGS="-Wno-error=unused-command-line-argument-hard-error-in-future" pip install ansible
#pip install --user ansible
sudo mkdir -p /etc/ansible/hosts && sudo chown -R $USER /etc/ansible
export ANSIBLE_NOCOWS=1
ansible-playbook -i localhost.inv osx.yml --ask-sudo-pass

[[ "$hacks" == "y" ]] && ./osx-hacks.sh

