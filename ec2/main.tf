module "vpc_lookups" {
  source = "../vpclookups"
  metadata = var.metadata
  tier_nb = "1"
}

data "aws_security_group" "vpc_sg" {
    vpc_id = module.vpc_lookups.vpc_id
    filter {
        name = "group-name"
        values = ["vpc_sg"]
    }
}

data "aws_security_group" "tier_sg" {
    vpc_id = module.vpc_lookups.vpc_id
    filter {
        name = "group-name"
        values = ["tier${var.tier_nb}_sg"]
    }
}

module "ec2creation" {
  source = "../ec2nodl"
  
  counter = var.counter
  metadata = var.metadata
  //ssh_pub_developer = var.ssh_pub_developer
  custom_userdata = var.custom_userdata

  vpc_id = module.vpc_lookups.vpc_id
  subnet_id = var.subnet_id
  sg_ids = "${concat(list(
      module.vpc_lookups.sg_id,
      data.aws_security_group.vpc_sg.id,
      data.aws_security_group.tier_sg.id,
  ), var.additional_sg_ids)}"

  short_name = var.short_name
  custom_tags = var.custom_tags
  instance_type = var.instance_type
  ami_name_regex = var.ami_name_regex
  eip_enabled = var.eip_enabled
  root_volume_size = var.root_volume_size

  //internal_domain_name = var.internal_domain_name

  attach_labeled_volumes = var.attach_labeled_volumes
  //sis_mount_vol_path = var.sis_mount_vol_path

  data_volume_size = var.data_volume_size
  data_volume_type = var.data_volume_type
  data_device_name = var.data_device_name
  //data_volume_name = var.data_volume_name
  data_volume_enabled = var.data_volume_enabled
}
