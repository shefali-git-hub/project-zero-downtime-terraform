
#-------AWS Provider-------#

provider "aws"{
    access_key = "${var.global_tags["access_key"]}"
    secret_key = "${var.global_tags["secret_key"]}"
    region ="${var.global_tags["region"]}"
  }
  
#-------- Data Section--------#
data "aws_lb " "alb" {
  name		=	"app-alb"-"${var.environment}"
}

#-------------DNS-----------#
resource "aws_route53_record" "this"{
	zone_id		=	"${var.zone_id}"
	name		=	"${var.service_record_name}"
	type		=	"A"
	
	alias {
		name					=	"${data.aws_lb.alb.app-alb-dns-name}"
		zone_id					=	"${var.zone_id}"
		evaluate_target_health	=	"true"
	}
