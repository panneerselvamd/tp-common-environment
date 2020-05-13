provider "aws" {
    region  = "us-east-2"
    version = "~> 2.61"
}

module "vpc_lookups" {
  source = "../vpclookups"
  metadata = var.metadata
  tier_nb = "1"
}

#####Add Separate Security Group for Jumphost######
resource "aws_security_group" "external_sg" {
    name = "external_sg"
    vpc_id = module.vpc_lookups.vpc_id

    #enable ssh access
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    #allow nslookup
    ingress {
        from_port = 53
        to_port = 53
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    #allow ping
    ingress {
        from_port = 8
        to_port = 0
        protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }
        
    #allow etcd from VPC CIDR Range
    ingress {
        from_port = 2379
        to_port = 2379
        protocol = "tcp"
        cidr_blocks = ["172.0.0.0/8"]
    }
        
    #allow all egress traffic
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

#####Add Separate Security Group for TradePortCommon######
resource "aws_security_group" "internal_sg" {
    name = "internal_sg"
    vpc_id = module.vpc_lookups.vpc_id

    #allow all ingress from VPC CIDR Range
    ingress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["172.0.0.0/8"]
    }

    #allow all egress only within VPC CIDR Range
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["172.0.0.0/8"]
    }
}

module "ec2jumphost" {
    source = "../ec2"

    counter = lookup(var.jumphost, "count", "1")
    tier_nb = "1"
    subnet_id = module.vpc_lookups.public_subnet_id   
    ssh_pub_developer = lookup(var.jumphost, "ssh_pub_developer", "")
    ami_name_regex = lookup(var.jumphost, "ami_name_regex", "")
    instance_type = lookup(var.jumphost, "instance_type", "")
    eip_enabled = lookup(var.jumphost, "eip_enabled", "")
    metadata = var.metadata
    short_name = "jumphost"
    additional_sg_ids = [aws_security_group.external_sg.id]

    custom_tags = {
        "role" = "jumphost"
    }
}