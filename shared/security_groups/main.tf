
#---------------AWS Provider-----------------#

provider "aws"{
    access_key = "${var.global_tags["access_key"]}"
    secret_key = "${var.global_tags["secret_key"]}"
    region ="${var.global_tags["region"]}"
  }

#-------------Security Group-----------------#

resource "aws_security_group" "security_group" {
  name        = "project-zero-downtime-server-sg"
  description = "sg for project-zero-downtime-server project"
 
 tags{
		Name = "project-zero-downtime-server-sg"-"${var.environment}"
		Environment = "${var.environment}"
	}
}
#-------------Security Group Rules-----------------#

resource "aws_security_group_rule" "ingress_rule" {
  description = "ingress rule for project-zero-downtime-server project"

  type      = "ingress"
  from_port = 0  
  to_port   = 65535
  protocol  = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.security_group.id}"
}

resource "aws_security_group_rule" "egress_rule" {
  description = "egress rule for project-zero-downtime-server project"

  type      = "egress"
  from_port = 0
  to_port   = 65535
  protocol  = "tcp"

  cidr_blocks = ["0.0.0.0/0"]
  security_group_id  = "${aws_security_group.security_group.id}"
}

