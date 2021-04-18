#!/bin/bash

cp common.yaml /etc/puppetlabs/code/environments/production/data/common.yaml
mkdir /etc/puppetlabs/code/environments/production/modules/role
cp -r modfoss_devel /etc/puppetlabs/code/environments/production/modules/role/

/opt/puppetlabs/bin/puppet apply -e "include modfoss_devel"
