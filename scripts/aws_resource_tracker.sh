#!/bin/bash

#############################################################
# Project Name : AWS Resource Tracker
# Author       : Krishna Kala
# Version      : v2.0
# Date         : 10-May-2026
#
# Description:
# This script automates AWS resource tracking using AWS CLI.
# It helps DevOps engineers monitor cloud infrastructure,
# improve visibility, and support cost optimization.
#
# Features:
# - AWS CLI validation
# - AWS authentication validation
# - Multi-service AWS resource tracking
# - Colored terminal output
# - Error handling
# - Empty resource handling
# - Modular Bash functions
# - Professional output formatting
#
# Supported AWS Services:
# 1. EC2
# 2. S3
# 3. IAM
# 4. Lambda
# 5. RDS
# 6. EBS
# 7. CloudFormation
#
# Usage:
# ./aws_resource_tracker.sh <region> <service>
#
# Example:
# ./aws_resource_tracker.sh us-east-1 ec2
#
#############################################################

#############################################################
# COLOR CODES
#############################################################

GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
BLUE="\e[34m"
CYAN="\e[36m"
RESET="\e[0m"

#############################################################
# TOOL BANNER
#############################################################

clear

echo -e "${BLUE}"
echo "=========================================================="
echo "              AWS RESOURCE TRACKER TOOL"
echo "=========================================================="
echo -e "${RESET}"

#############################################################
# STORE USER INPUTS
#############################################################

region=$1
service=$2

#############################################################
# INPUT VALIDATION
#############################################################

if [ $# -ne 2 ]
then
    echo -e "${RED}ERROR: Invalid number of arguments provided.${RESET}"
    echo ""
    echo "Usage:"
    echo "./aws_resource_tracker.sh <region> <service>"
    echo ""
    echo "Example:"
    echo "./aws_resource_tracker.sh us-east-1 ec2"
    echo ""
    echo "Supported services:"
    echo "ec2 | s3 | iam | lambda | rds | ebs | cloudformation"
    exit 1
fi

#############################################################
# AWS CLI VALIDATION
#############################################################

if ! command -v aws &> /dev/null
then
    echo -e "${RED}ERROR: AWS CLI is not installed.${RESET}"
    echo ""
    echo "Install AWS CLI and try again."
    exit 1
fi

echo -e "${GREEN}SUCCESS: AWS CLI is installed.${RESET}"

#############################################################
# AWS AUTHENTICATION VALIDATION
#############################################################

aws sts get-caller-identity &> /dev/null

if [ $? -ne 0 ]
then
    echo -e "${RED}ERROR: AWS CLI is not configured properly.${RESET}"
    echo ""
    echo "Run the following command:"
    echo "aws configure"
    exit 1
fi

echo -e "${GREEN}SUCCESS: AWS CLI is configured properly.${RESET}"

#############################################################
# DISPLAY EXECUTION DETAILS
#############################################################

echo ""
echo -e "${CYAN}Region  : ${region}${RESET}"
echo -e "${CYAN}Service : ${service}${RESET}"
echo ""

#############################################################
# RESOURCE FETCHING FUNCTIONS
#############################################################

#############################################################
# EC2 INSTANCES
#############################################################

list_ec2_instances() {

    echo -e "${YELLOW}Fetching EC2 instances...${RESET}"
    echo ""

    instances=$(aws ec2 describe-instances \
        --region "$region" \
        --query "Reservations[*].Instances[*].[InstanceId,State.Name]" \
        --output table)

    if [ -z "$instances" ]
    then
        echo -e "${RED}No EC2 instances found in region: $region${RESET}"
    else
        echo "$instances"
    fi
}

#############################################################
# S3 BUCKETS
#############################################################

list_s3_buckets() {

    echo -e "${YELLOW}Fetching S3 buckets...${RESET}"
    echo ""

    buckets=$(aws s3 ls)

    if [ -z "$buckets" ]
    then
        echo -e "${RED}No S3 buckets found.${RESET}"
    else
        echo "$buckets"
    fi
}

#############################################################
# IAM USERS
#############################################################

list_iam_users() {

    echo -e "${YELLOW}Fetching IAM users...${RESET}"
    echo ""

    users=$(aws iam list-users \
        --query "Users[*].[UserName]" \
        --output table)

    if [ -z "$users" ]
    then
        echo -e "${RED}No IAM users found.${RESET}"
    else
        echo "$users"
    fi
}

#############################################################
# LAMBDA FUNCTIONS
#############################################################

list_lambda_functions() {

    echo -e "${YELLOW}Fetching Lambda functions...${RESET}"
    echo ""

    functions=$(aws lambda list-functions \
        --query "Functions[*].[FunctionName,Runtime]" \
        --output table)

    if [ -z "$functions" ]
    then
        echo -e "${RED}No Lambda functions found.${RESET}"
    else
        echo "$functions"
    fi
}

#############################################################
# RDS DATABASES
#############################################################

list_rds_instances() {

    echo -e "${YELLOW}Fetching RDS databases...${RESET}"
    echo ""

    databases=$(aws rds describe-db-instances \
        --region "$region" \
        --query "DBInstances[*].[DBInstanceIdentifier,Engine,DBInstanceStatus]" \
        --output table)

    if [ -z "$databases" ]
    then
        echo -e "${RED}No RDS databases found in region: $region${RESET}"
    else
        echo "$databases"
    fi
}

#############################################################
# EBS VOLUMES
#############################################################

list_ebs_volumes() {

    echo -e "${YELLOW}Fetching EBS volumes...${RESET}"
    echo ""

    volumes=$(aws ec2 describe-volumes \
        --region "$region" \
        --query "Volumes[*].[VolumeId,Size,State]" \
        --output table)

    if [ -z "$volumes" ]
    then
        echo -e "${RED}No EBS volumes found in region: $region${RESET}"
    else
        echo "$volumes"
    fi
}

#############################################################
# CLOUDFORMATION STACKS
#############################################################

list_cloudformation_stacks() {

    echo -e "${YELLOW}Fetching CloudFormation stacks...${RESET}"
    echo ""

    stacks=$(aws cloudformation describe-stacks \
        --region "$region" \
        --query "Stacks[*].[StackName,StackStatus]" \
        --output table)

    if [ -z "$stacks" ]
    then
        echo -e "${RED}No CloudFormation stacks found in region: $region${RESET}"
    else
        echo "$stacks"
    fi
}

#############################################################
# SERVICE SELECTION ENGINE
#############################################################

case $service in

    ec2)
        list_ec2_instances
        ;;

    s3)
        list_s3_buckets
        ;;

    iam)
        list_iam_users
        ;;

    lambda)
        list_lambda_functions
        ;;

    rds)
        list_rds_instances
        ;;

    ebs)
        list_ebs_volumes
        ;;

    cloudformation)
        list_cloudformation_stacks
        ;;

    *)
        echo ""
        echo -e "${RED}ERROR: Invalid AWS service provided.${RESET}"
        echo ""
        echo "Supported services:"
        echo "ec2 | s3 | iam | lambda | rds | ebs | cloudformation"
        exit 1
        ;;

esac

#############################################################
# SCRIPT COMPLETION MESSAGE
#############################################################

echo ""
echo -e "${GREEN}AWS Resource Tracking Completed Successfully.${RESET}"
echo ""