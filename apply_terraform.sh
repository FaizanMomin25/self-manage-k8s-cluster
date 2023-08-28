#!/bin/bash

shopt -s nocasematch

echo "This script will initialize Terraform and apply the configuration to create resources."
echo "Are you sure you want to proceed? (y/n)"

read answer

case $answer in
    y|n)
        if [[ "$answer" != "y" ]]; then
            echo "Aborting Terraform apply."
            exit 0
        fi
        read -p "How many worker nodes you want to deploy?" WORKER_NUM
        echo "num_workers = $WORKER_NUM" > custom.tfvars
        echo "Initializing Terraform..."
        terraform init

        echo "Applying Terraform configuration..."
        terraform apply -var-file="custom.tfvars" -auto-approve

        if [ $? -eq 0 ]; then
            echo "Terraform apply successful!"
        else
            echo "Terraform apply failed. Please check the error messages above."
        fi
    ;;
    *)
        echo "Please provide valid input (y/n)"
    ;;
esac

