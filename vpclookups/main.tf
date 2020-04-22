data "aws_vpc" "vpc" {
    default = false
    filter {
      name = "cidr"
      values = ["${local.vpc_cidr}"]
    }
}

data "aws_subnet" "subnet" {
    vpc_id = "${data.aws_vpc.vpc.id}"
    filter {
        name = "cidrBlock"
        values = ["${local.subnet_cidr}"]
    }
}

data "aws_security_group" "sg" {
    vpc_id = "${data.aws_vpc.vpc.id}"
    filter {
        name = "group-name"
        values = ["tier${var.tier_nb}_sg"]
    }
}