#!/bin/bash

KEY=$HOME/.ssh/id_ed25519_ansible

if [ ! -f "$KEY" ]; then
    ssh-keygen -t ed25519 -N "" -f "$KEY" -C "ansible@personal"
    echo "Created $KEY."
fi

ansible-playbook playbooks/distribute.yml -k
