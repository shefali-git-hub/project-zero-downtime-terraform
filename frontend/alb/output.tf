output	"id"	{
	value	=	"${aws_lb.app-alb.id}"
}

output	"arn"	{
	value	=	"${aws_lb.app-alb.arn}"
}

output	"dns_name"	{
	value	=	"${aws_lb.app-alb.dns_name}"
}

output	"zone_id"	{
	value	=	"${aws_lb.app-alb.zone_id}"
}

output	"tg_id"	{
	value	=	"${aws_lb_target_group.app-alb-target-group.id}"
}

output	"tg_name"	{
	value	=	"${aws_lb_target_group.app-alb-target-group.name}"
}

output	"tg_arn"	{
	value	=	"${aws_lb_target_group.app-alb-target-group.arn}"
}