#!/bin/bash

SET_HOSTNAME=$1

if [ ! -z $SET_HOSTNAME ]; then
    hostnamectl set-hostname $SET_HOSTNAME
fi

apt-get update
apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo   "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
	$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
wget https://apt.puppet.com/puppet-tools-release-buster.deb
wget https://apt.puppet.com/puppet7-release-buster.deb
dpkg -i puppet-tools-release-buster.deb puppet7-release-buster.deb
rm puppet-tools-release-buster.deb puppet7-release-buster.deb
apt-get update
apt-get install -y kitty-terminfo puppet-agent pdk docker-ce docker-ce-cli containerd.io docker-compose

# Add the module path declaration.
echo 'modulepath = ./modules/base:./modules/profile:./modules/role:$basemodulepath' > \
    /etc/puppetlabs/code/environments/production/environment.conf

# Install puppet modules
/opt/puppetlabs/bin/puppet module install puppetlabs-accounts
/opt/puppetlabs/bin/puppet module install puppetlabs-ntp
/opt/puppetlabs/bin/puppet module install saz-sudo

# Download Repo
git clone https://github.com/symkat/modfoss_devel.git

echo
echo
echo The system has been set up for puppet to run, however you must finish
echo editing the configuration and then run puppet.
echo
echo cd modfoss_devel
echo vim common.yaml
echo ./puppet-first-run.sh
echo
echo After that, re-running puppet can be done with the following command:
echo
echo /opt/puppetlabs/bin/puppet apply -e \"include modfoss_devel\"
echo
echo
