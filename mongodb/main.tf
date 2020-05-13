provider "aws" {
    region  = "us-east-2"
    version = "~> 2.61"
}

module "vpc_lookups" {
  source = "../vpclookups"
  metadata = var.metadata
  tier_nb = "1"
}

module "ec2mongo" {
    source = "../ec2"

    counter = lookup(var.mongo, "count")
    tier_nb = "1"
    ssh_pub_developer = lookup(var.mongo, "ssh_pub_developer", "")
    ami_name_regex = lookup(var.mongo, "ami_name_regex", "")
    instance_type = lookup(var.mongo, "instance_type", "")
    custom_userdata = file("${path.module}/userdata.sh")
    metadata = var.metadata
    short_name = "mongodb"
    data_volume_size = lookup(var.mongo, "data_volume_size")
    data_volume_type = lookup(var.mongo, "data_volume_type")
    data_device_name = lookup(var.mongo, "data_device_name")
    data_volume_enabled = lookup(var.mongo, "data_volume_enabled")
    additional_sg_ids = [data.aws_security_group.internal_sg.id, aws_security_group.mongodb_external_sg.id]
    eip_enabled = lookup(var.mongo, "eip_enabled", "")
    custom_tags = {
        "role" = "mongodb"
    }
}

data "aws_vpc" "vpc" {
    default = false
    filter {
        name = "cidr"
        values = [local.vpc_cidr]
    }
}

data "aws_security_group" "internal_sg" {
    vpc_id = data.aws_vpc.vpc.id
    filter {
        name = "group-name"
        values = ["internal_sg"]
    }
}

resource "aws_security_group" "mongodb_external_sg" {
    name = "mongodb_external_sg"
    vpc_id = module.vpc_lookups.vpc_id

    ingress {
        from_port = 27017
        to_port = 27017
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
}