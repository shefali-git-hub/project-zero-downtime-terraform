
#---------------Stograge/S3 Variables---------------#

variable "global_tags" {
type	= "map"
description	= "Global variables used across the stacks"
}
variable "main_bucket_acl" {}
variable "bucket_name" {}
variable "environment" {}
