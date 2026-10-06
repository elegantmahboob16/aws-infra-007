output "public_ip" {
  value = aws_eip.ip.public_ip
}

output "allocation_id" {
  value = aws_eip.ip.allocation_id
}