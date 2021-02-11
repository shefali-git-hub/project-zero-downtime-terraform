
#-------AWS Provider-------#

provider "aws"{
    access_key = "${var.global_tags["access_key"]}"
    secret_key = "${var.global_tags["secret_key"]}"
    region ="${var.global_tags["region"]}"
  }
  
#-------- Data Section--------#
/*
data "aws_ami" "ami"{
most_recent = true
	owners      = ["self"]
	filter{
		name = "tag:Name"
		values = ["${var.ami_name]}"]
	}
}
*/
data "aws_security_group" "sg" {
  name = "${var.security_group_name}"
}

#---------- EC2 resource-------#

resource "aws_instance" "compute"{
	ami = "ami-0eb094e431a3874cc"
	instance_type = "t2.micro"
	vpc_security_group_ids = ["${data.aws_security_group.sg.id}"]
	associate_public_ip_address = true
	tags{
		Name = "project-zero-downtime-server"-"${var.environment}"
		Environment = "${var.environment}"
	}
}
