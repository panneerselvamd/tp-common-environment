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
        
    #allow etcd
    ingress {
        from_port = 2379
        to_port = 2379
        protocol = "tcp"
        cidr_blocks = ["172.0.0.0/8"]
    }
        
    #allow all in egress
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

    #allow all ingress
    ingress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["172.0.0.0/8"]
    }

    #allow all egress
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["172.0.0.0/8"]
    }
}

module "jumphost" {
    source = "../ec2"

    counter = "${lookup(var.jumphost, "count", "1")}"
    tier_nb = "1"
    ssh_pub_developer = "${lookup(var.jumphost, "ssh_pub_developer", "")}"
    ami_name_regex = "${lookup(var.jumphost, "ami_name_regex", "")}"
    instance_type = "${lookup(var.jumphost, "instance_type", "")}"
    eip_enabled = "${lookup(var.jumphost, "eip_enabled", "")}"
    metadata = var.metadata
    short_name = "jumphost"
    additional_sg_ids = ["${aws_security_group.external_sg.id}"]

    custom_tags = {
        "role" = "jumphost"
    }
}