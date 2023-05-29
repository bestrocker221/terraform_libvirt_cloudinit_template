#!/bin/bash

function create {
	POOLID=$(pwgen 5 1);  \
	echo "Generated pool ID: $POOLID"; \
	echo "Enter project name: "; \
	read PROJNAME;  \
	sed 's/PROJNAME/'$PROJNAME'/' tmpl/variables.tf.tmpl > variables.tf && \
	sed 's/POOLID/'$POOLID'/' tmpl/main.tf.tmpl > main.tf && \
	sed 's/POOLID/'$POOLID'/' tmpl/vm.tf.tmpl.orig > tmpl/vm.tf.tmpl
	echo "Terraform files updated correctly" && \
	terraform init -upgrade
	# creates vm.tf and tmp vm.tf.tmpl
}

function addvm {

	# Prompt the user for variable values
	read -p "Enter VM name (it will also be its hostname): " vmname ;\
	read -p "Enter VM size in GB: " vmsize ;\
	read -p "Enter VM CPU count: " vmcpu ;\
	read -p "Enter VM RAM in GB: " vmram ;\
	
	sed 's/VMNAMECHANGEME/'$vmname'/g' tmpl/vm.tf.tmpl > "${vmname}".tf &&\
	sed -i 's/vmsize/'$vmsize'/g' "${vmname}".tf &&\
	sed -i 's/vmcpu/'$vmcpu'/g' "${vmname}".tf &&\
	sed -i 's/vmram/'$vmram'/g'  "${vmname}".tf #&&\
	# creates vmname.tf
	terraform init -upgrade
}

function deploy {
	terraform apply
}

function destroy {
	terraform destroy
}
function clean {
	terraform destroy
	rm -rf tmpl/vm.tf.tmpl *.tf terraform.* .terraform.lock.hcl .terraform
}

if [ $# -ne 1 ]; then
  echo "Usage: $0 [create|addvm|deploy|destroy|clean]"
  exit 1
fi

case "$1" in
  "create")
	echo "Calling create function..."
    create
    ;;
  "addvm")
    echo "Calling addvm function..."
    addvm
    ;;
  "deploy")
    echo "Calling deploy function..."
    deploy
    ;;
  "destroy")
    echo "Calling destroy function..."
    destroy
    ;;
  "clean")
    echo "Calling clean function..."
    clean
    ;;
  *)
    echo "Invalid argument: $1"
    echo "Usage: $0 [create|addvm|deploy|destroy|clean]"
    exit 1
    ;;
esac
