# ANSIBLE Post Deployment
Roles folder used is my github repo, just do:

`git clone git@github.com:bestrocker221/ansible_useful.git roles`

Look at the different roles and expand/customize if you will.

By default the playbook included does:
```yml
    - upgrade
    - install_packages
    - install_sublimetext
    - install_oh-my-zsh
    - install_spice_guest_tools
    - install_xfce
    - reboot
```

If you do not want a DE environment just delete the `install_xfce` and `install_spice_guest_tools` so the the VM will be ready in no time.

Add more packages you want to be installed in the list contained in the `playbook-base.yml`.

The user for the VM is `user` as it was created with cloudinit and already contains your public SSH key.
