# Terraform vm creation

Version 0.3

`Usage: ./helper.sh [create|addvm|deploy|destroy|clean]`

1. create: initialize project with a random name
2. addvm: creates new vm file, will ask for cpu, mem, disk etc
3. deploy: will deploy the terraform files
4. destroy: will tier down created infra
5. clean: will tier down terraform infra and delete files. Goes back to original state

# note
For now the VMs will be using Debian.

The initial cloudinit config sets default passwords and your ssh key. (Default passwords are stupid, just set at your own risk or change it as you will )

Further post-install can be done in ansible.
