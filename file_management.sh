#!/bin/bash

# Welcome message
echo "Welcome to the File Management System!"
echo "Please choose an option:"

# Display options to the user
echo "1. Create a new file"
echo "2. Delete a file"
echo "3. Rename a file"
echo "4. Copy a file"
echo "5. Move a file"
echo "6. Create a new directory"
echo "7. Delete a directory"
echo "8. Create a backup of a file/directory"
echo "9. Set permissions of a file/directory"
echo "10. List files in a directory"
echo "11. Search for a file in a directory"
echo "12. Compress a file"
echo "13. Extract files from a compressed archive"
echo "14. Edit a file"
echo "15. Securely delete a file"
echo "16. View file contents"
echo "17. Exit"

# Read user's choice
read choice

# Execute the corresponding command based on the user's choice
case $choice in
  1) 
    # Create a new file
    echo "Please enter the name of the file you wish to create: "
    read filename
    touch $filename
    echo "File created successfully"
    ;;
  2) 
    # Delete a file
    echo "Please enter the name of the file you wish to delete: "
    read filename
    rm $filename
    echo "File deleted successfully"
    ;;
  3) 
    # Rename a file
    echo "Please enter the name of the file you wish to rename: "
    read filename
    echo "Please enter the new name for the file: "
    read newname
    mv $filename $newname
    echo "File renamed successfully"
    ;;
  4) 
    # Copy a file
    echo "Please enter the name of the file you wish to copy: "
    read filename
    echo "Please enter the name of the new file: "
    read newname
    cp $filename $newname
    echo "File copied successfully"
    ;;
  5) 
    # Move a file
    echo "Please enter the name of the file you wish to move: "
    read filename
    echo "Please enter the new path for the file: "
    read path
    mv $filename $path
    echo "File moved successfully"
    ;;
  6)
    # Create a new directory
    echo "Please enter the name of the directory you wish to create: "
    read dirname
    mkdir $dirname
    echo "Directory created successfully"
    ;;
  7)
    # Delete a directory
    echo "Please enter the name of the directory you wish to delete: "
    read dirname
    rm -r $dirname
    echo "Directory deleted successfully"
    ;;
  8)
    # Create a backup of a file/directory recursively
    echo "Please enter the name of the file/directory you wish to create a backup of: "
    read source
    echo "Please enter the name of the backup file/directory: "
    read backup_name
    tar -czvf $backup_name.tar.gz $source
    echo "Backup created successfully"
    
    # Prompt the user for a recursive backup
    echo "Do you want to create a recursive backup of subdirectories (y/n)?"
    read choice
    
    # If the user chooses to create a recursive backup, create a separate backup for each subdirectory
    if [ "$choice" == "y" ]; then
      for dir in $source/*; do
        if [ -d $dir ]; then
          subdir=$(basename $dir)
          echo "Creating backup for subdirectory: $subdir"
          backup_subdir="${backup_name}_${subdir}"
          tar -czvf $backup_subdir.tar.gz $dir
          echo "Backup for subdirectory $subdir created successfully"
        fi
      done
    fi
    ;;
  9)
    # Set permissions of a file/directory
    echo "Please enter the name of the file or directory whose permissions you wish to set: "
    read filename
    echo "Please enter the new permissions in numeric format (e.g. 755): "
    read perms
    chmod $perms $filename
    echo "Permissions set successfully"
    ;;
  10)
    # List files in a directory
    echo "Please enter the name of the directory you wish to list the files of: "
    read dirname
    ls -l $dirname
    ;;
  11)
    # Search for a file in a directory
    echo "Please enter the name of the file you wish to search for: "
    read filename
    echo "Please enter the directory in which to search for the file: "
    read dirname
    find $dirname -name $filename
    ;;
  12)
    # Compress a file
    echo "Please enter the name of the file you wish to compress: "
    read filename
    gzip $filename
    echo "File compressed successfully"
    ;;
  13)
    # Extract files from a compressed archive
    echo "Please enter the name of the archive you wish to extract: "
    read filename
    tar -xzvf $filename
    echo "Archive extracted successfully"
    ;;
  14)
    # Edit a file
    echo "Please enter the name of the file you wish to edit: "
    read filename
    vi $filename
    echo "File edited successfully"
    ;;
  15)
    # Securely delete a file
    echo "Please enter the name of the file you wish to securely delete: "
    read filename
    shred -u $filename
    echo "File securely deleted"
    ;;
  16)
    # View file contents
    echo "Please enter the name of the file you wish to view: "
    read filename
    cat $filename
    ;;
  17)
    # Exit the script
    echo "Exiting the file management system..."
    exit
    ;;
    *)
    echo "Invalid choice. Please choose an option between 1 and 19."
;;
esac
