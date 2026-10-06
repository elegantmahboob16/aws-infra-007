variable "instance_type" {
  description = "AWS instance type"
  type        = string
  default     = "t3.micro"
}

variable "AMI_ID" {
  description = "AMI ID for the instance"
  type        = string
  default     = "ami-0f8a61b66d1accaee"
}

variable "name" {
  description = "Name tag for the instance"
  type        = string
  default     = "web_server"
}

variable "key_name" {
  description = "Key pair name for SSH access"
  type        = string
  default     = "my-key-pair"
}
variable "subnet_id" {
  description = "Subnet ID for the instance"
  type        = string
  default     = "aws_subnet.public_subnet.id"
}

variable "vpc_security_group_ids" {
  description = "List of security group IDs to associate with the instance"
  type        = list(string)
  default     = ["aws_security_group.my_security_group.id"]
}



variable "user_data" {
  description = "User data script to configure the instance"
  type        = string
  default     = <<-EOF
                #!/bin/bash
                sudo apt update -y
                sudo apt install nginx -y
                sudo systemctl start nginx
                EOF
}

variable "tags" {
  description = "Tags to apply to the instance"
  type        = map(string)
  default = {
    Name = "my_ec2"
  }
}