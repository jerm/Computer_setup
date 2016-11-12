#!/bin/bash

install_virtualbox(){
    VIRTUALBOX_URL=$(curl https://www.virtualbox.org/wiki/Downloads | grep dmg | egrep -o 'http.*dmg')
    VIRTUALBOX_VERSION=$(echo $VIRTUALBOX_URL | cut -f5 -d/)
    VIRTUALBOX_FILE=$(echo $VIRTUALBOX_URL | cut -f6 -d/)
    pushd ~/Downloads/
    curl -O $VIRTUALBOX_URL
    hdiutil attach ~/Downloads/$VIRTUALBOX_FILE
    sudo installer -pkg /Volumes/VirtualBox/VirtualBox.pkg -target /
    popd()
}
install_vagrant(){
    vagrant_url_osx=$(curl http://www.vagrantup.com/downloads.html |tr ' ' '\n'| grep -oE "ht
    tp.*dmg")
    vagrant_url_deb=$(curl http://www.vagrantup.com/downloads.html |tr ' ' '\n'| grep -oE "http.*64.deb")
    vagrant_version=$( echo $vagrant_url_osx | grep -oE "([0-9]*\.){2}[0-9]*")

    pushd ~/Downloads/
    curl -O -L  $vagrant_url_osx
    hdiutil attach ~/Downloads/${vagrant_url_osx##*/}
    sudo installer -pkg /Volumes/Vagrant/Vagrant.pkg -target /
    popd
    for i in vagrant-global-status vagrant-cachier vagrant-vbguest; do
        vagrant plugin install $i
    done
}

install_homebrew(){
    ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
    brew doctor
}

sudo easy_install pip
install_virtualbox
install_vagrant
install_homebrew


#sudo ARCHFLAGS="-Wno-error=unused-command-line-argument-hard-error-in-future" pip install ansible
pip install --user ansible
    sudo mkdir -p /etc/ansible/hosts && sudo chown -R $USER /etc/ansible
    export ANSIBLE_NOCOWS=1
open http://getmacapps.com/
open https://www.hipchat.com/downloads
# appstore: mirosoft remote desktop, tweetbot, hashtab
open http://www.crashplan.com
open http://ridiculousfish.com/hexfiend/
#open http://www.kekaosx.com/en/
open http://tapbots.com/software/tweetbot/mac/
open http://macromates.com/download
open http://www.teamviewer.com/en/download/mac.aspx
open http://bjango.com/mac/istatmenus/
open https://www.keepassx.org/
open https://xquartz.macosforge.org/landing/
open http://wiki.mikrotik.com/wiki/MikroTik_WinBox_for_Mac_StandAlone

## (not needed for winbox anymore) winebottler http://winebottler.kronenberg.org/downloads

# remember http://rogueamoeba.com/  for audio tools
ansible-playbook -i localhost.inv osx.yml --ask-sudo-pass

./osx-hacks.sh

