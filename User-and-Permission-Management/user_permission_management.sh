#!/bin/bash

# Function to create a new user
create_user() {
  local username=$1
  echo "Creating user: $username"
  # Create user and set home directory
  sudo useradd -m -s /bin/bash $username
  if [ $? -eq 0 ]; then
    echo "User $username created successfully."
  else
    echo "Error: User creation failed."
    exit 1
  fi
}

# Function to create a new group
create_group() {
  local groupname=$1
  echo "Creating group: $groupname"
  # Create group
  sudo groupadd $groupname
  if [ $? -eq 0 ]; then
    echo "Group $groupname created successfully."
  else
    echo "Error: Group creation failed."
    exit 1
  fi
}

# Function to add user to a group
add_user_to_group() {
  local username=$1
  local groupname=$2
  echo "Adding user $username to group $groupname"
  # Add user to group
  sudo usermod -aG $groupname $username
  if [ $? -eq 0 ]; then
    echo "User $username added to group $groupname successfully."
  else
    echo "Error: Failed to add user to group."
    exit 1
  fi
}

# Function to set file permissions
set_permissions() {
  local filepath=$1
  local permissions=$2
  echo "Setting permissions $permissions on file $filepath"
  # Set file permissions
  sudo chmod $permissions $filepath
  if [ $? -eq 0 ]; then
    echo "Permissions $permissions set on file $filepath."
  else
    echo "Error: Failed to set permissions."
    exit 1
  fi
}

# Function to change ownership
change_ownership() {
  local filepath=$1
  local owner=$2
  local group=$3
  echo "Changing ownership of $filepath to $owner:$group"
  # Change ownership of file
  sudo chown $owner:$group $filepath
  if [ $? -eq 0 ]; then
    echo "Ownership changed to $owner:$group for $filepath."
  else
    echo "Error: Failed to change ownership."
    exit 1
  fi
}

# Main menu function
show_menu() {
  echo "User and Permission Management"
  echo "1. Create User"
  echo "2. Create Group"
  echo "3. Add User to Group"
  echo "4. Set File Permissions"
  echo "5. Change File Ownership"
  echo "6. Exit"
}

# User interaction
while true; do
  show_menu
  read -p "Choose an option (1-6): " choice
  case $choice in
    1)
      read -p "Enter the username to create: " username
      create_user $username
      ;;
    2)
      read -p "Enter the group name to create: " groupname
      create_group $groupname
      ;;
    3)
      read -p "Enter the username: " username
      read -p "Enter the group name to add user to: " groupname
      add_user_to_group $username $groupname
      ;;
    4)
      read -p "Enter the file path: " filepath
      read -p "Enter the permissions (e.g., 755): " permissions
      set_permissions $filepath $permissions
      ;;
    5)
      read -p "Enter the file path: " filepath
      read -p "Enter the owner: " owner
      read -p "Enter the group: " group
      change_ownership $filepath $owner $group
      ;;
    6)
      echo "Exiting program."
      exit 0
      ;;
    *)
      echo "Invalid option, please choose a number between 1 and 6."
      ;;
  esac
done

