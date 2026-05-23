<div align="center">

#  AWS Resource Tracker

**A DevOps automation tool to monitor and track AWS cloud resources directly from your terminal**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Bash](https://img.shields.io/badge/Bash-Scripting-4EAA25?logo=gnubash&logoColor=white)](https://www.gnu.org/software/bash/)
[![AWS CLI](https://img.shields.io/badge/AWS-CLI-FF9900?logo=amazonaws&logoColor=white)](https://aws.amazon.com/cli/)
[![Linux](https://img.shields.io/badge/Linux-Compatible-FCC624?logo=linux&logoColor=black)](https://www.linux.org/)
[![Shell](https://img.shields.io/badge/Shell-Script-89e051)](https://en.wikipedia.org/wiki/Shell_script)

*Built to improve cloud infrastructure visibility and automate resource tracking using Bash and AWS CLI.*

</div>

---

##  Overview

Managing AWS infrastructure manually becomes increasingly difficult as cloud resources grow. **AWS Resource Tracker** is a lightweight Bash automation tool that gives DevOps engineers instant visibility into their AWS environment — no console login required.

Run a single command from your terminal to fetch, validate, and display any AWS resource in a clean, color-coded output.

```bash
./aws_resource_tracker.sh us-east-1 ec2
```

---

##  Features

- ✅ **AWS CLI validation** — auto-checks if AWS CLI is installed before running
- ✅ **Authentication verification** — validates AWS credentials are configured
- ✅ **7 supported AWS services** — EC2, S3, IAM, Lambda, RDS, EBS, CloudFormation
- ✅ **Colored terminal output** — clear, human-readable formatting
- ✅ **Robust error handling** — graceful messages for invalid inputs & empty resources
- ✅ **Modular function design** — clean, reusable Bash functions per service
- ✅ **Case-statement service routing** — fast, extensible service selection engine
- ✅ **Zero dependencies** — only requires Bash and AWS CLI

---

##  Supported AWS Services

| Service | Command Keyword | What It Tracks |
|---|---|---|
| EC2 | `ec2` | Virtual machine instances |
| S3 | `s3` | Storage buckets |
| IAM | `iam` | Users and access identities |
| Lambda | `lambda` | Serverless functions |
| RDS | `rds` | Managed relational databases |
| EBS | `ebs` | Block storage volumes |
| CloudFormation | `cloudformation` | Infrastructure stacks |

---

##  Project Structure

```
aws-resource-tracker/
│
├── scripts/
│   └── aws_resource_tracker.sh    # Core tracking script
│
├── screenshots/                   # Terminal output screenshots
│
├── docs/
│   └── project-explanation.md     # Detailed project walkthrough
│
├── README.md
├── LICENSE
└── .gitignore
```

---

##  How It Works

```
User Input (region + service)
         │
         ▼
  Input Validation
  (argument count check)
         │
         ▼
  AWS CLI Check
  (is it installed?)
         │
         ▼
  Auth Validation
  (are credentials configured?)
         │
         ▼
  Service Selection Engine
  (case-statement routing)
         │
         ▼
  AWS Resource Fetch
  (per-service function call)
         │
         ▼
  Formatted Output Display
```

---

##  Getting Started

### Prerequisites

- Linux / macOS terminal
- [AWS CLI v2](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) installed
- AWS account with appropriate IAM read permissions
- Git

---

### Step 1 — Clone the Repository

```bash
git clone https://github.com/krishnakala987-byte/aws-resource-tracker.git
cd aws-resource-tracker/scripts
```

### Step 2 — Grant Execute Permission

```bash
chmod +x aws_resource_tracker.sh
```

### Step 3 — Configure AWS CLI

```bash
aws configure
```

You'll be prompted for:

| Field | Example |
|---|---|
| AWS Access Key ID | `AKIAIOSFODNN7EXAMPLE` |
| AWS Secret Access Key | `wJalrXUtnFEMI/K7MDENG/...` |
| Default Region | `us-east-1` |
| Output Format | `json` |

---

##  Usage

**Syntax:**
```bash
./aws_resource_tracker.sh <region> <service>
```

**Examples:**

```bash
# Track EC2 Instances
./aws_resource_tracker.sh us-east-1 ec2

# Track S3 Buckets
./aws_resource_tracker.sh us-east-1 s3

# Track IAM Users
./aws_resource_tracker.sh us-east-1 iam

# Track Lambda Functions
./aws_resource_tracker.sh us-east-1 lambda

# Track RDS Databases
./aws_resource_tracker.sh us-east-1 rds

# Track EBS Volumes
./aws_resource_tracker.sh us-east-1 ebs

# Track CloudFormation Stacks
./aws_resource_tracker.sh us-east-1 cloudformation
```

---

##  Example Output

```
==========================================================
              AWS RESOURCE TRACKER TOOL
==========================================================

✔ SUCCESS: AWS CLI is installed.
✔ SUCCESS: AWS CLI is configured properly.

  Region  : us-east-1
  Service : ec2

Fetching EC2 instances...

+----------------------+-----------+
| i-06bd492924c0980d0 | running   |
+----------------------+-----------+

AWS Resource Tracking Completed Successfully.
```

---

##  Error Handling

The script handles all common failure scenarios clearly:

| Scenario | Error Message |
|---|---|
| No arguments provided | `ERROR: Invalid number of arguments provided.` |
| Unsupported service name | `ERROR: Invalid AWS service provided.` |
| AWS CLI not installed | `ERROR: AWS CLI is not installed.` |
| AWS credentials not configured | `ERROR: AWS CLI is not configured properly.` |
| No resources found | Clean "No resources found" message |

**Examples:**

```bash
# Missing arguments
./aws_resource_tracker.sh
# ERROR: Invalid number of arguments provided.

# Unsupported service
./aws_resource_tracker.sh us-east-1 mongodb
# ERROR: Invalid AWS service provided.
```

---

##  Technologies Used

| Technology | Purpose |
|---|---|
| **Bash** | Core scripting language |
| **AWS CLI** | Fetching AWS resource data |
| **Linux** | Script execution environment |
| **Git & GitHub** | Version control & hosting |

---

##  Roadmap

Planned enhancements for future versions:

- [ ] Logging system — save output to timestamped log files
- [ ] Multi-region scanning — scan all regions in one command
- [ ] Slack / SNS notifications — alert on resource changes
- [ ] CloudWatch integration — metric-based tracking
- [ ] Docker containerization — portable, no-install setup
- [ ] CI/CD pipeline — auto-run on schedule via GitHub Actions
- [ ] Cost optimization reports — flag idle/unused resources
- [ ] Interactive menu UI — guided terminal interface for non-CLI users

---

##  Contributing

Contributions are welcome! Here's how:

1. Fork the repository
2. Create a feature branch — `git checkout -b feature/your-feature`
3. Commit your changes — `git commit -m 'feat: add your feature'`
4. Push to the branch — `git push origin feature/your-feature`
5. Open a Pull Request

Please follow [Conventional Commits](https://www.conventionalcommits.org/) for commit messages.

---

##  License

This project is licensed under the [MIT License](LICENSE).

---

##  Author

**Krishna Kala**  
*Aspiring DevOps & Cloud Engineer*

[![GitHub](https://img.shields.io/badge/GitHub-krishnakala987--byte-181717?logo=github)](https://github.com/krishnakala987-byte)

---

<div align="center">
<sub> If this project helped you, consider giving it a star on GitHub!</sub>
</div>