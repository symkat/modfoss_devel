# modFoss Devel

modfoss_devel is a bootstraping system to turn a Debian 10 machine into a development server.  It sets up a basic puppet installation to manage packages and shell accounts, and installs docker.

It was created as part of the blog post [Creating my development environment](https://modfoss.com/creating-my-development-environment.html)

## Bootstraping a devel environment

To setup a development environment from a root shell on a fresh Debian 10 installation, run the following.

```sh
curl https://raw.githubusercontent.com/symkat/modfoss_devel/master/install.sh \
    | bash -s - yourhost.com
```

Once this script completes, you will need to `cd modfoss_devel` and edit the file `common.yaml`.  Pay particular attention to the lines with ! marks in them.  You should replace the symkat username with whichever username you use and update the SSH keys with your own public keys.

```yaml
accounts::user_list:
!  symkat:
    groups:
      - sudo
      - docker
    sshkeys:
!      - ssh-rsa AAAAB3Nzas....== symkat@laptop
!      - ssh-rsa AAAAB3Nsdf....== symkat@desktop
```

After this, complete the installation by running `./puppet-first-run.sh`

If you add more users to `common.yaml` or extend `init.pp` in the future, you can run the puppet module again with `puppet apply -e "include modfoss_devel"`.


