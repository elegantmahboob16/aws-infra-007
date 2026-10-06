# AWS Infrastructure with Terraform

This project provisions AWS infrastructure using **Terraform**. It creates a VPC, public subnets, EC2 instance, S3 bucket, Lambda function, IAM role, Elastic IP, Security Group, and CloudWatch alarm.

## Architecture

The Terraform project creates the following AWS resources:

* VPC
* Internet Gateway
* 2 Public Subnets
* Public Route Table
* Security Group
* EC2 Instance
* Elastic IP
* S3 Bucket
* AWS Lambda Function
* IAM Role
* IAM Policy Attachment
* CloudWatch CPU Alarm

## Project Structure

```text
aws-infra-007/
│
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
├── providers.tf
│
├── modules/
│   ├── vpc/
│   ├── ec2/
│   ├── s3/
│   ├── lambda/
│   ├── securitygroup/
│   ├── elastic_ip/
│   └── cloudwatch/
│
├── lambda/
│   └── lambda_function.py
│
└── README.md
```

> Your exact filenames and folder names may be different depending on your Terraform project.

## Prerequisites

Install the following before running the project:

* Terraform
* AWS CLI
* AWS account
* AWS IAM user/role with required permissions
* Existing EC2 key pair

Check Terraform:

```powershell
terraform version
```

Check AWS CLI:

```powershell
aws --version
```

Check AWS authentication:

```powershell
aws sts get-caller-identity
```

## AWS Authentication

Configure AWS CLI:

```powershell
aws configure
```

Enter:

```text
AWS Access Key ID:
AWS Secret Access Key:
Default region name:
Default output format:
```

Example region:

```text
ap-south-1
```

**Never upload AWS access keys or secret keys to GitHub.**

## Terraform Initialization

Navigate to the project directory:

```powershell
cd D:\my-local-files\aws-infra-007
```

Initialize Terraform:

```powershell
terraform init
```

This downloads the required Terraform providers and initializes the modules.

## Format Terraform Files

Run:

```powershell
terraform fmt -recursive
```

This formats Terraform files according to Terraform's standard formatting.

## Validate Configuration

Run:

```powershell
terraform validate
```

Expected result:

```text
Success! The configuration is valid.
```

## Create Terraform Plan

Run:

```powershell
terraform plan
```

Terraform may ask for variables such as:

```text
var.key_name
Name of the existing EC2 key pair
Enter a value:
```

Enter your AWS EC2 key-pair name.

Example:

```text
zoro.pem
```

For SSH access:

```text
var.ssh_allowed_cidr
Enter a value:
```

For testing:

```text
0.0.0.0/0
```

However, this allows SSH access from anywhere on the internet and is **not recommended for production**.

A safer option is:

```text
YOUR_PUBLIC_IP/32
```

## Apply Infrastructure

After reviewing the plan:

```powershell
terraform apply
```

Terraform will ask for confirmation:

```text
Do you want to perform these actions?
  Enter a value:
```

Enter:

```text
yes
```

Terraform will then create or update the AWS resources.

## Current Terraform Status

The infrastructure has been successfully checked with:

```powershell
terraform plan
```

Terraform reported:

```text
No changes. Your infrastructure matches the configuration.
```

This means the AWS infrastructure currently matches the Terraform configuration.

## View Outputs

Run:

```powershell
terraform output
```

To view a specific output:

```powershell
terraform output <output_name>
```

## Connecting to the EC2 Instance

After Terraform creates the EC2 instance, find its public IP:

```powershell
terraform output
```

Then connect using SSH:

```powershell
ssh -i .\zoro.pem ubuntu@<EC2_PUBLIC_IP>
```

For Amazon Linux, the username may be:

```text
ec2-user
```

Example:

```powershell
ssh -i .\zoro.pem ec2-user@<EC2_PUBLIC_IP>
```

The correct username depends on the AMI used by your Terraform configuration.

## Destroy Infrastructure

To remove all resources managed by Terraform:

```powershell
terraform destroy
```

Terraform will ask for confirmation.

Enter:

```text
yes
```

**Warning:** `terraform destroy` can permanently delete AWS resources and their data.

## Important Security Notes

### 1. Avoid `0.0.0.0/0` for SSH

This:

```text
0.0.0.0/0
```

allows anyone on the internet to attempt an SSH connection.

Prefer:

```text
YOUR_PUBLIC_IP/32
```

For example:

```text
203.0.113.25/32
```

### 2. Protect your PEM file

Do not upload:

```text
*.pem
```

to GitHub.

Add this to `.gitignore`:

```gitignore
*.pem
*.key
terraform.tfstate
terraform.tfstate.*
.terraform/
.terraform.lock.hcl
*.tfvars
```

If `terraform.tfvars` contains AWS credentials or other secrets, never commit it to a public repository.

### 3. Protect AWS Credentials

Never put credentials directly inside Terraform files:

```hcl
aws_access_key = "YOUR_ACCESS_KEY"
aws_secret_key = "YOUR_SECRET_KEY"
```

Use AWS CLI profiles, environment variables, or IAM roles instead.

## Useful Terraform Commands

| Command                | Purpose                      |
| ---------------------- | ---------------------------- |
| `terraform init`       | Initialize Terraform         |
| `terraform fmt`        | Format Terraform files       |
| `terraform validate`   | Validate configuration       |
| `terraform plan`       | Preview changes              |
| `terraform apply`      | Create/update infrastructure |
| `terraform output`     | Display outputs              |
| `terraform show`       | Show current state           |
| `terraform state list` | List managed resources       |
| `terraform destroy`    | Delete infrastructure        |

## Troubleshooting

### Terraform command not found

Check:

```powershell
terraform version
```

If Terraform is not recognized, add the Terraform installation directory to the Windows `PATH`.

### AWS authentication error

Check:

```powershell
aws sts get-caller-identity
```

Then configure credentials:

```powershell
aws configure
```

### EC2 SSH permission denied

Check that:

1. The EC2 key pair name is correct.
2. The `.pem` file matches the AWS key pair.
3. The Security Group allows TCP port `22`.
4. The EC2 instance has a public IP/Elastic IP.
5. The SSH username matches the AMI.

## Cleanup

When you no longer need the AWS infrastructure:

```powershell
terraform destroy
```

Always check the Terraform plan before confirming destructive operations.

---

## Author

**Mahboob Omer**

AWS + Terraform Infrastructure Project

## License

This project is for learning and demonstration purposes.
