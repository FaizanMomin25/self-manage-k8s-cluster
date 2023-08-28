#!/bin/bash

shopt -s nocasematch

echo "This script will destroy the resources created by Terraform."
echo "Are you sure you want to proceed? (y/n)"

read answer

case $answer in
    y|n)
        if [[ "$answer" != "y" ]]; then
            echo "Aborting Terraform destroy."
            exit 0
        fi

        echo "Destroying Terraform resources..."
        terraform destroy -var-file="custom.tfvars" -auto-approve
        
        if [ $? -eq 0 ]; then
            echo "Terraform destroy successful!"
        else
            echo "Terraform destroy failed. Please check the error messages above."
        fi
    ;;
    *)
        echo "Please provide valid input (y/n)"
    ;;
esac