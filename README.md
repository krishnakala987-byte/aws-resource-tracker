# AWS Resource Tracker

A professional DevOps automation project built using **Bash scripting** and **AWS CLI** to track and monitor AWS cloud resources directly from the terminal.

This project was created to improve cloud infrastructure visibility, automate resource tracking, and strengthen real-world DevOps scripting skills using AWS services.

---

# Project Overview

Managing AWS infrastructure manually becomes difficult as cloud resources increase.

This automation tool helps DevOps engineers quickly fetch and track AWS resources such as:

- EC2 Instances
- S3 Buckets
- IAM Users
- Lambda Functions
- RDS Databases
- EBS Volumes
- CloudFormation Stacks

The script validates AWS CLI installation, verifies AWS authentication, handles invalid inputs, and displays AWS resource information in a clean terminal interface.

---

# Features

- AWS CLI validation
- AWS authentication verification
- Multi-service AWS resource tracking
- Colored terminal output
- Error handling and validation
- Empty resource handling
- Professional Bash scripting structure
- Modular reusable functions
- Case statement-based service selection
- Infrastructure visibility automation
- Beginner-friendly DevOps project structure

---

# Supported AWS Services

| AWS Service | Purpose |
|---|---|
| EC2 | Track virtual machines |
| S3 | Track storage buckets |
| IAM | Track IAM users |
| Lambda | Track serverless functions |
| RDS | Track managed databases |
| EBS | Track storage volumes |
| CloudFormation | Track infrastructure stacks |

---

# Technologies Used

- Bash Scripting
- Linux
- AWS CLI
- Git & GitHub
- AWS Cloud Services

---

# Project Structure

```text
aws-resource-tracker/
│
├── scripts/
│   └── aws_resource_tracker.sh
│
├── screenshots/
│
├── docs/
│   └── project-explanation.md
│
├── README.md
├── LICENSE
└── .gitignore
```

---

# Workflow Architecture

```text
User Input
     ↓
Input Validation
     ↓
AWS CLI Validation
     ↓
AWS Authentication Validation
     ↓
Service Selection Engine
     ↓
AWS Resource Fetching Functions
     ↓
Formatted Output Display
```

---

# Installation & Setup

## Step 1 — Clone Repository

```bash
git clone https://github.com/YOUR-USERNAME/aws-resource-tracker.git
```

---

## Step 2 — Navigate Into Project

```bash
cd aws-resource-tracker/scripts
```

---

## Step 3 — Give Execute Permission

```bash
chmod +x aws_resource_tracker.sh
```

---

## Step 4 — Configure AWS CLI

```bash
aws configure
```

You will be asked for:

- AWS Access Key
- AWS Secret Access Key
- Default Region
- Output Format

---

# Usage

## Track EC2 Instances

```bash
./aws_resource_tracker.sh us-east-1 ec2
```

---

## Track S3 Buckets

```bash
./aws_resource_tracker.sh us-east-1 s3
```

---

## Track IAM Users

```bash
./aws_resource_tracker.sh us-east-1 iam
```

---

## Track Lambda Functions

```bash
./aws_resource_tracker.sh us-east-1 lambda
```

---

## Track RDS Databases

```bash
./aws_resource_tracker.sh us-east-1 rds
```

---

## Track EBS Volumes

```bash
./aws_resource_tracker.sh us-east-1 ebs
```

---

## Track CloudFormation Stacks

```bash
./aws_resource_tracker.sh us-east-1 cloudformation
```

---

# Example Output

```text
==========================================================
              AWS RESOURCE TRACKER TOOL
==========================================================

SUCCESS: AWS CLI is installed.
SUCCESS: AWS CLI is configured properly.

Region  : us-east-1
Service : ec2

Fetching EC2 instances...

+----------------------+-----------+
| i-06bd492924c0980d0 | running   |
+----------------------+-----------+

AWS Resource Tracking Completed Successfully.
```

---

# Error Handling

The script handles multiple failure scenarios professionally.

## Invalid Arguments

```bash
./aws_resource_tracker.sh
```

Output:

```text
ERROR: Invalid number of arguments provided.
```

---

## Invalid AWS Service

```bash
./aws_resource_tracker.sh us-east-1 mongodb
```

Output:

```text
ERROR: Invalid AWS service provided.
```

---

## AWS CLI Not Installed

```text
ERROR: AWS CLI is not installed.
```

---

## AWS Authentication Failure

```text
ERROR: AWS CLI is not configured properly.
```

---

# DevOps Concepts Used

This project demonstrates practical DevOps concepts such as:

- Infrastructure Automation
- Bash Scripting
- Linux Permissions
- AWS CLI Automation
- Cloud Resource Monitoring
- Input Validation
- Error Handling
- Defensive Programming
- Modular Scripting
- Infrastructure Visibility
- Cloud Operations

---

# Learning Outcomes

Through this project I learned:

- Real-world Bash scripting
- AWS CLI usage
- AWS authentication workflows
- Linux command execution
- Shell scripting best practices
- Function-based scripting
- Case statement implementation
- Error handling techniques
- AWS infrastructure visibility concepts
- Git & GitHub project management

---

# Future Improvements

Future enhancements planned for this project:

- Logging system
- Multi-region scanning
- Slack notifications
- CloudWatch integration
- Docker containerization
- CI/CD pipeline integration
- Cost optimization reports
- Interactive menu-based UI

---

# Why This Project Matters

This project simulates a real-world DevOps automation use case where cloud engineers need quick visibility into AWS infrastructure resources.

It demonstrates practical knowledge of:

- Linux
- AWS
- Bash scripting
- Automation
- Infrastructure monitoring
- DevOps engineering workflows

---

# Screenshots

## EC2 Resource Tracking

(Add screenshot here)

---

## S3 Bucket Tracking

(Add screenshot here)

---

## Invalid Service Validation

(Add screenshot here)

---

# Author

## Krishna Kala

Aspiring DevOps & Cloud Engineer

Passionate about:
- Cloud Computing
- DevOps Automation
- Linux
- AWS
- Infrastructure Engineering

---