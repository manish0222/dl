#!/bin/bash

REPO_OWNER="manish0222"
REPO_NAME="dl"
GITHUB_API="https://api.github.com"
RAW_CONTENT_URL="https://raw.githubusercontent.com"

# No need to ask for a subject, since there's only one directory with all files
SUBJECT="DL"

files_json=$(wget -qO- "${GITHUB_API}/repos/${REPO_OWNER}/${REPO_NAME}/contents/${SUBJECT}")

if echo "$files_json" | grep -q "Not Found"; then
    echo "Error: Directory not found."
    exit 1
fi

# Define the specific files to present as options
declare -a files=("AutoEncoder_5,14.txt" "CBOW_6,7,8,15.txt" "CNN_CIFAR_4.txt" "CNN_MNIST_2,13.txt" "Feed_Forward_CIFAR10_3.txt" "feed_Forward_MNIST__1,12.txt" "Transfer_Learning_9,10,11,16.txt")

# Display files as options
echo "Files in DL:"
for i in "${!files[@]}"; do
    echo "$((i + 1))) ${files[i]}"
done

echo "Enter the number of the file you want to download:"
read file_number

# Ensure valid selection
if [ "$file_number" -ge 1 ] && [ "$file_number" -le "${#files[@]}" ]; then
    selected_file="${files[file_number-1]}"
else
    echo "Invalid selection."
    exit 1
fi

# Download the selected file
wget -q "${RAW_CONTENT_URL}/${REPO_OWNER}/${REPO_NAME}/main/${SUBJECT}/${selected_file}" -O "$selected_file"

if [ $? -eq 0 ]; then
    echo "File '$selected_file' has been downloaded successfully."
else
    echo "Error downloading the file."
    exit 1
fi
