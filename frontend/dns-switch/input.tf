
#---------------DNS-Switch Variables---------------#
variable "global_tags" {
type = "map"
description = "global variables"
}
variable "zone_id" {}
variable "hosted_zone" {}
variable "service_record_name" {}
variable "main_service_record_name" {}