#!/bin/bash

# Function to display the menu
display_menu() {
    echo "Select a Git action:"
    echo "1. Clone a repository"
    echo "2. Add files"
    echo "3. Commit changes"
    echo "4. Push to remote"
    echo "5. Pull from remote"
    echo "6. Check status"
    echo "7. Exit"
}

# Function to execute Git actions
perform_action() {
    case $1 in
        1)
            read -p "Enter the repository URL to clone: " repo_url
            git clone "$repo_url"
            ;;
        2)
            read -p "Enter the files or patterns to add (or leave empty for all): " files
            git add ${files:-.}
            echo "Files added."
            ;;
        3)
            read -p "Enter the commit message: " commit_msg
            git commit -m "$commit_msg"
            echo "Changes committed."
            ;;
        4)
            read -p "Enter the remote branch to push (default: main): " branch
            git push origin ${branch:-main}
            echo "Changes pushed."
            ;;
        5)
            read -p "Enter the remote branch to pull (default: main): " branch
            git pull origin ${branch:-main}
            echo "Changes pulled."
            ;;
        6)
            git status
            ;;
        7)
            echo "Exiting script."
            exit 0
            ;;
        *)
            echo "Invalid option. Please try again."
            ;;
    esac
}

# Main script loop
while true; do
    display_menu
    read -p "Enter your choice: " choice
    perform_action "$choice"
    echo
done

