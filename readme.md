# Terraform vm creation

Version 0.4

`Usage: ./helper.sh [create|addvm|deploy|destroy|clean]`

1. create: initialize project with a random name
2. addvm: creates new vm file, will ask for cpu, mem, disk etc
3. deploy: will deploy the terraform files
4. destroy: will tier down created infra
5. clean: will tier down terraform infra and delete files. Goes back to original state

# Good points

1. The libvirt project uses the current user context, *nothing runs as root*.

2. The pool gets generated dynamically per-project.

3. The common path chosen for the pools is `~/KVM` where the domains qcow files will be stored. Change in vars if wanted

4. The `ssh_key_path` variable contains the path to the local ssh key to import into the newly generated VM. Change to your liking 

# note
For now the VMs will be using Debian 11.

The initial cloudinit config sets default passwords and your ssh key. (Default passwords are stupid, just set at your own risk or change it as you will )

Further post-install can be done in ansible.
