#ec2 instances for my project

resource "aws_instance" "my_ec2" {
  ami                    = var.AMI_ID
  instance_type          = var.instance_type
  vpc_security_group_ids = var.vpc_security_group_ids
  subnet_id              = var.subnet_id
  key_name               = trimsuffix(var.key_name, ".pem")


  user_data = var.user_data


  tags = merge(var.tags, { Name = var.name })
}
