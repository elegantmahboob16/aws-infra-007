resource "aws_eip" "ip" {
  domain   = "vpc"
  instance = var.instance_id
  tags     = var.tags
}