# output for ec2 instance

output "public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.my_ec2.public_ip
}

output "instance_id" {
  description = "ID of the EC2 instance"
  value = aws_instance.my_ec2.id
}