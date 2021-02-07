
#-------AWS Provider-------#

provider "aws"{
    access_key = "${var.global_tags["access_key"]}"
    secret_key = "${var.global_tags["secret_key"]}"
    region ="${var.global_tags["region"]}"
  }
  
#-------- DNS--------#
resource "aws_route53_record" "this"	{
	zone_id		=	"${var.zone_id}"
	name		=	"${var.main_service_record_name}"."${var.hosted_zone}"
	type		=	"CNAME"
	ttl			=	"300"
	records		=	"${var.service_record_name}"."${var.hosted_zone}"
}