#!/bin/bash

container_name="$1"

if id "$container_name" &>/dev/null; then
    echo "User $container_name already exists."
else
    echo "Creating user $container_name..."
    sudo useradd --system --no-create-home "$container_name"
fi
id "$container_name"
if id -nG "$container_name" 2>/dev/null | grep -qw "containers"; then
    echo "User $container_name is already in the containers group."
else
    echo "Adding user $container_name to the containers group..."
    sudo usermod -aG containers "$container_name"
fi

sudo chown -R "$container_name":containers "/containers/$container_name"
sudo chmod -R 770 "/containers/$container_name"
sudo chmod 660 "/containers/$container_name/.env"