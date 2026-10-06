variable "alarm_name" { type = string }
variable "instance_id" { type = string }
variable "cpu_threshold" {
  type    = number
  default = 70
}
variable "tags" {
  type    = map(string)
  default = {}
}
