# aws-resource-tracker

A small Bash and AWS CLI toolkit that inventories what you are running across AWS, so you are not clicking through the console to find out.

## What it does

- Inventories 7 AWS services in one run: EC2, S3, IAM, Lambda, RDS, EBS, and CloudFormation.
- Validates credentials before it starts, so it fails clearly instead of halfway through.
- Writes structured, timestamped logs and uses exit codes properly, so it can run unattended.
- Uses jq to turn raw AWS CLI output into clean reports.
- Runs on a schedule through cron and GitHub Actions for recurring cloud audits.

## Stack

Bash, AWS CLI, jq, cron, GitHub Actions.
