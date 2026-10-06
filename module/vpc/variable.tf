variable "name" {
  type = string
}
variable "vpc_name" {
  type = string
}
variable "public_subnet_name" {
  type = string
}
variable "public_subnet_name2" {
  type = string
}
variable "igw_name" {
  type = string
}
variable "public_route_table_name" {
  type = string
}
variable "tags" {
  type    = map(string)
  default = {}
}