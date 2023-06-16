# Terraform vm creation

Version 0.4

`Usage: ./helper.sh [create|addvm|deploy|destroy|clean]`

## quick start
```sh
./helper.sh create
./helper.sh addvm
..
..
./helper.sh deploy
./helper.sh destroy (or "clean" if you want to return to clean folder)
```

## what does it do?

1. create: initialize project, it will ask for a name
2. addvm: creates new vm file, it will ask for cpu, mem, disk etc
3. deploy: will deploy the terraform files
4. destroy: will tier down created infra
5. clean: will tier down terraform infra and delete files. Goes back to original state

# Good to know
Since we want to run in the "user-mode" we do not have access to some network settings, so the default network used here is a bridge interface `virbr1`.

From a root session, I created a NAT network which will be named virbr1. This way, we can attach to it from the user-mode session without any root privileges.

You can create as many networks as you want in the system session, then reference to them in the terraform variables, ready to be used in the project. The script does not ask for a network for now, just puts into the default virbr1 (can be changed/added in no time).

## SSH
Ex: you name a VM `chip01` ? after deployment you are ready to SSH into it with ` ssh debian@chip01`

# Good points

1. The libvirt project uses the current user context, *nothing runs as root*.

2. The pool gets generated dynamically per-project.

3. The common path chosen for the pools is `~/KVM` where the domains qcow files will be stored. Change in vars if wanted

4. The `ssh_key_path` variable contains the path to the local ssh key to import into the newly generated VM. Change to your liking 

5. The first step is to download the debian cloudinit image file. Then libvirt will use this image as base image for all the other VMs created. This way the space used for 1..n VMs will be reduced.

# note
For now the VMs will be using Debian 12.

The initial cloudinit config sets default passwords and your ssh key. (Default passwords are stupid, just set at your own risk or change it as you will )

Further post-install can be done in ansible.

# POST DEPLOYMENT

`ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i VMNAME, -e "privkeypath=~/.ssh/<YOURKEYHERE>" ansible/playbook-base.yml`
