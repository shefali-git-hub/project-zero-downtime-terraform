
#-------------- AWS Prodivder-----------------#
provider "aws" {
    access_key = "${var.global_tags["access_key"]}"
    secret_key = "${var.global_tags["secret_key"]}"
    region ="${var.global_tags["region"]}"
}

#--------------- S3 Bucket---------------------#
resource "aws_s3_bucket" "s3_bucket" {
  bucket = "${var.bucket_name}"
  acl    = "${var.bucket_acl}"
  region = "${var.region}"
   
 tags{
		Name = "project-zero-downtime-server"-s3-"${var.environment}"
		Environment = "${var.environment}"
	}
}
