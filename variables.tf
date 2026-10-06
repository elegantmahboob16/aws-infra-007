variable "name" {
  description = "Base name for the infrastructure resources"
  type        = string
  default     = "aws-infra-ass"
}

variable "vpc_name" {
  type    = string
  default = "aws-infra-ass-vpc"
}

variable "public_subnet_name" {
  type    = string
  default = "aws-infra-ass-public-subnet-1"
}

variable "public_subnet_name2" {
  type    = string
  default = "aws-infra-ass-public-subnet-2"
}

variable "igw_name" {
  type    = string
  default = "aws-infra-ass-igw"
}

variable "public_route_table_name" {
  type    = string
  default = "aws-infra-ass-public-route-table"
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "ssh_allowed_cidr" {
  description = "CIDR range allowed to connect to the instance over SSH"
  type        = string
}

variable "AMI_ID" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-0f8a61b66d1accaee"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "user_data" {
  description = "User data script to configure the EC2 instance"
  type        = string
  default     = <<-EOF
    #!/bin/bash
    sudo apt update -y
    sudo apt install nginx -y
    sudo systemctl start nginx
  EOF
}

variable "key_name" {
  description = "Name of the existing EC2 key pair"
  type        = string
}

variable "bucket_name" {
  description = "Globally unique name for the S3 bucket"
  type        = string
  default     = "aws-infra-ass-530751148683-20261006"
}

variable "lambda_function_name" {
  type    = string
  default = "aws-infra-ass-function"
}

variable "lambda_runtime" {
  type    = string
  default = "python3.12"
}

variable "cpu_threshold" {
  type    = number
  default = 70
}
