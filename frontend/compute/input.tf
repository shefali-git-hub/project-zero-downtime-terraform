
#---------------ASG Variables---------------#

variable "global_tags" {
type = "map"
description = "global variables"
}
variable "ami_name" {}
variable "instance_type" {}
variable "environment" {}
variable "security_group_name" {}

