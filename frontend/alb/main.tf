
#-------AWS Provider-------#

provider "aws"{
    access_key = "${var.global_tags["access_key"]}"
    secret_key = "${var.global_tags["secret_key"]}"
    region ="${var.global_tags["region"]}"
  }
  
#-------- Data Section--------#

data "aws_vpc" "vpc"{
most_recent = true
	owners      = ["self"]
	filter{
		name = "tag:VPC"
		values = ["${var.vpc_id]}"]
	}
	
	state	= "available"
}

data "aws_subnet" "amber"{
	count	= "2"
	owners      = ["self"]
	filter{
		name = "tag:VPC"
		values = ["${var.vpc_id]}"]
	}
	
	state	= "available"
}

data "aws_security_group" "sg" {
  name = "${var.security_group_name}"
}

#-------------ALB-----------#
resource "aws_lb" "app-alb"{
	name								= "blue-green-app-alb"-"${var.environment}"
	security_groups						= ["data.aws_security_group.sg.id"]
	subnets								= ["data.aws_subnet.amber.id"]
	internal							= "true"
	load_balancer_type					= "application"
	enable_cross_zone_load_balancing	= "true"
	
	tags	{
		Name		=	"app-alb"-"${var.environment}"
		Environment	=	"${var.environment}"
	}
}

#-------------Target Groups-----------#
resource "aws_lb_target_group" "app-alb-target-group"{
	name		=	"app-alb-tg"-"${var.environment}"
	port		=	"80"
	protocol	=	"HTTP"
	vpc_id		=	"data.aws_vpc.vpc.id"
	deregistration_delay	=	"300"
	
	tags	{
		Name		=	"app-alb"-tg-"${var.environment}"
		Environment	=	"${var.environment}"
	}
	
	)

#-------------Listeners-----------#
resource "aws_lb_listeners" "app-alb-listeners"{
	load_balancer_arn	=	"${aws_lb.app-alb.arn}"
	port		=	"80"
	protocol	=	"HTTP"
	
	default_action	{
		target_group_arn	=	"${aws_lb_target_group.app-alb-target-group.arn}"
		type				=	"forward"
	}
	
}

#-------------Listeners Rule-----------#
resource "aws_lb_listener_rule" "app-alb-listener_rule"{
	listener_arn	=	"${aws_lb_listeners.app-alb-listeners.arn}"
	priority		=	"1"
	
	action	{
		target_group_arn	=	"${aws_lb_target_group.app-alb-target-group.arn}"
		type				=	"forward"
	}
	
}