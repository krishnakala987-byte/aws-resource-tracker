#!/bin/bash

#############################################################
# Project Name : AWS Resource Tracker
# Author       : Krishna Kala
# Version      : v3.0
# Date         : 01-Jul-2026
#
# Description:
# Automates AWS resource tracking using AWS CLI. Helps DevOps
# engineers monitor infrastructure, improve visibility, and
# support cost optimization.
#
# Features:
# - AWS CLI validation
# - AWS authentication validation
# - Multi-service AWS resource tracking
# - Colored terminal output
# - Structured logging to timestamped log files      # NEW (v3.0)
# - "all" mode for scheduled / cron full reports      # NEW (v3.0)
# - Error handling and empty-resource handling
# - Modular Bash functions
#
# Supported AWS Services:
# 1. EC2  2. S3  3. IAM  4. Lambda  5. RDS  6. EBS  7. CloudFormation
#
# Usage:
#   ./aws_resource_tracker.sh <region> <service>
#   ./aws_resource_tracker.sh us-east-1 ec2
#   ./aws_resource_tracker.sh us-east-1 all      # full report (ideal for cron)
#
# Cron example (daily full report at 06:00):
#   0 6 * * * /path/to/aws_resource_tracker.sh us-east-1 all
#############################################################

set -o pipefail

#############################################################
# COLOR CODES
#############################################################
GREEN="\e[32m"; RED="\e[31m"; YELLOW="\e[33m"; BLUE="\e[34m"; CYAN="\e[36m"; RESET="\e[0m"

#############################################################
# STRUCTURED LOGGING SETUP   (NEW in v3.0)
#############################################################
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_DIR="${SCRIPT_DIR}/logs"
mkdir -p "$LOG_DIR"
TIMESTAMP="$(date +%F_%H-%M-%S)"
LOG_FILE="${LOG_DIR}/aws_resource_tracker_${TIMESTAMP}.log"

# log <LEVEL> <message> : append a structured, timestamped line to the log file
log() {
    local level="$1"; shift
    printf '[%s] [%-7s] %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$level" "$*" >> "$LOG_FILE"
}

# record <text> : strip ANSI colors and append raw resource output to the log file
record() {
    printf '%b\n' "$*" | sed -r 's/\x1B\[[0-9;]*[mK]//g' >> "$LOG_FILE"
}

log INFO "AWS Resource Tracker started (pid $$)"

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
if [ $# -ne 2 ]; then
    echo -e "${RED}ERROR: Invalid number of arguments provided.${RESET}"
    echo ""
    echo "Usage: ./aws_resource_tracker.sh <region> <service>"
    echo "Example: ./aws_resource_tracker.sh us-east-1 ec2"
    echo "Services: ec2 | s3 | iam | lambda | rds | ebs | cloudformation | all"
    log ERROR "Invalid argument count ($#) - exiting"
    exit 1
fi

#############################################################
# AWS CLI VALIDATION
#############################################################
if ! command -v aws &> /dev/null; then
    echo -e "${RED}ERROR: AWS CLI is not installed.${RESET}"
    log ERROR "AWS CLI not installed - exiting"
    exit 1
fi
echo -e "${GREEN}SUCCESS: AWS CLI is installed.${RESET}"
log INFO "AWS CLI validation passed"

#############################################################
# AWS AUTHENTICATION VALIDATION
#############################################################
aws sts get-caller-identity &> /dev/null
if [ $? -ne 0 ]; then
    echo -e "${RED}ERROR: AWS CLI is not configured properly.${RESET}"
    echo "Run: aws configure"
    log ERROR "AWS authentication failed - exiting"
    exit 1
fi
echo -e "${GREEN}SUCCESS: AWS CLI is configured properly.${RESET}"
log INFO "AWS authentication validation passed"

#############################################################
# DISPLAY EXECUTION DETAILS
#############################################################
echo ""
echo -e "${CYAN}Region  : ${region}${RESET}"
echo -e "${CYAN}Service : ${service}${RESET}"
echo ""
log INFO "Execution context - region=${region} service=${service}"

#############################################################
# RESOURCE FETCHING FUNCTIONS
#############################################################
list_ec2_instances() {
    echo -e "${YELLOW}Fetching EC2 instances...${RESET}"; echo ""
    log INFO "Fetching EC2 instances in ${region}"
    instances=$(aws ec2 describe-instances --region "$region" \
        --query "Reservations[*].Instances[*].[InstanceId,State.Name]" --output table)
    if [ -z "$instances" ]; then
        echo -e "${RED}No EC2 instances found in region: $region${RESET}"
        log WARN "No EC2 instances found in ${region}"
    else
        echo "$instances"; record "EC2 INSTANCES:"; record "$instances"
        log INFO "EC2 instances fetched"
    fi
}

list_s3_buckets() {
    echo -e "${YELLOW}Fetching S3 buckets...${RESET}"; echo ""
    log INFO "Fetching S3 buckets"
    buckets=$(aws s3 ls)
    if [ -z "$buckets" ]; then
        echo -e "${RED}No S3 buckets found.${RESET}"; log WARN "No S3 buckets found"
    else
        echo "$buckets"; record "S3 BUCKETS:"; record "$buckets"; log INFO "S3 buckets fetched"
    fi
}

list_iam_users() {
    echo -e "${YELLOW}Fetching IAM users...${RESET}"; echo ""
    log INFO "Fetching IAM users"
    users=$(aws iam list-users --query "Users[*].[UserName]" --output table)
    if [ -z "$users" ]; then
        echo -e "${RED}No IAM users found.${RESET}"; log WARN "No IAM users found"
    else
        echo "$users"; record "IAM USERS:"; record "$users"; log INFO "IAM users fetched"
    fi
}

list_lambda_functions() {
    echo -e "${YELLOW}Fetching Lambda functions...${RESET}"; echo ""
    log INFO "Fetching Lambda functions in ${region}"
    functions=$(aws lambda list-functions --region "$region" \
        --query "Functions[*].[FunctionName,Runtime]" --output table)
    if [ -z "$functions" ]; then
        echo -e "${RED}No Lambda functions found.${RESET}"; log WARN "No Lambda functions found"
    else
        echo "$functions"; record "LAMBDA FUNCTIONS:"; record "$functions"; log INFO "Lambda functions fetched"
    fi
}

list_rds_instances() {
    echo -e "${YELLOW}Fetching RDS databases...${RESET}"; echo ""
    log INFO "Fetching RDS databases in ${region}"
    databases=$(aws rds describe-db-instances --region "$region" \
        --query "DBInstances[*].[DBInstanceIdentifier,Engine,DBInstanceStatus]" --output table)
    if [ -z "$databases" ]; then
        echo -e "${RED}No RDS databases found in region: $region${RESET}"; log WARN "No RDS databases found"
    else
        echo "$databases"; record "RDS DATABASES:"; record "$databases"; log INFO "RDS databases fetched"
    fi
}

list_ebs_volumes() {
    echo -e "${YELLOW}Fetching EBS volumes...${RESET}"; echo ""
    log INFO "Fetching EBS volumes in ${region}"
    volumes=$(aws ec2 describe-volumes --region "$region" \
        --query "Volumes[*].[VolumeId,Size,State]" --output table)
    if [ -z "$volumes" ]; then
        echo -e "${RED}No EBS volumes found in region: $region${RESET}"; log WARN "No EBS volumes found"
    else
        echo "$volumes"; record "EBS VOLUMES:"; record "$volumes"; log INFO "EBS volumes fetched"
    fi
}

list_cloudformation_stacks() {
    echo -e "${YELLOW}Fetching CloudFormation stacks...${RESET}"; echo ""
    log INFO "Fetching CloudFormation stacks in ${region}"
    stacks=$(aws cloudformation describe-stacks --region "$region" \
        --query "Stacks[*].[StackName,StackStatus]" --output table)
    if [ -z "$stacks" ]; then
        echo -e "${RED}No CloudFormation stacks found in region: $region${RESET}"; log WARN "No CloudFormation stacks found"
    else
        echo "$stacks"; record "CLOUDFORMATION STACKS:"; record "$stacks"; log INFO "CloudFormation stacks fetched"
    fi
}

#############################################################
# SERVICE SELECTION ENGINE  ( 'all' added for cron reports )
#############################################################
case $service in
    ec2)            list_ec2_instances ;;
    s3)             list_s3_buckets ;;
    iam)            list_iam_users ;;
    lambda)         list_lambda_functions ;;
    rds)            list_rds_instances ;;
    ebs)            list_ebs_volumes ;;
    cloudformation) list_cloudformation_stacks ;;
    all)
        log INFO "Running FULL report across all services"
        list_ec2_instances
        list_s3_buckets
        list_iam_users
        list_lambda_functions
        list_rds_instances
        list_ebs_volumes
        list_cloudformation_stacks
        ;;
    *)
        echo -e "${RED}ERROR: Invalid AWS service provided.${RESET}"
        echo "Services: ec2 | s3 | iam | lambda | rds | ebs | cloudformation | all"
        log ERROR "Invalid service '${service}' - exiting"
        exit 1
        ;;
esac

#############################################################
# SCRIPT COMPLETION MESSAGE
#############################################################
echo ""
echo -e "${GREEN}AWS Resource Tracking Completed Successfully.${RESET}"
echo -e "${CYAN}Structured log saved to: ${LOG_FILE}${RESET}"
echo ""
log INFO "AWS Resource Tracker completed successfully"
