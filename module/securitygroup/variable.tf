variable "name" { type = string }
variable "description" { type = string }
variable "vpc_id" { type = string }
variable "ssh_allowed_cidr" { type = string }
variable "tags" {
  type    = map(string)
  default = {}
}
