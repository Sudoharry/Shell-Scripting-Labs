#!/bin/bash

# Clean temporary files
sudo rm -rf /tmp/*
sudo rm -rf /var/tmp/*

# Clean APT cache
sudo apt-get clean
sudo apt-get autoclean
sudo apt-get autoremove -y

# Clean logs
sudo journalctl --vacuum-size=100M

# Remove Docker junk
docker system prune -a --volumes -f

# Remove Snap old versions
sudo snap list --all | awk '/disabled/{print $1, $3}' | while read snapname revision; do sudo snap remove "$snapname" --revision="$revision"; done

# Done
echo "Cleanup completed!"
