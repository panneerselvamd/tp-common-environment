variable "mongo" {
  type = map
  default = {
      "count" = "3"
      "ssh_pub_developer" = ""
      "ami_name_regex" = ""
      "instance_type" = "t2.micro"
      "data_volume_size" = "10"
      "data_volume_type" = "gp2"
      "data_device_name" = "/dev/sdf"
      "data_volume_enabled" = "1"
      "eip_enabled" = "true"
  }
}

variable "metadata" {
  type = map
  default = {
    env_subtype = "dev"
    datacenter = "wf1"
    external_segment = "cib"
    internal_segment = "tradeportcommon"
    component = "mongodb"
    component_kv_store = ""
    vault_addr = ""
    vpc_offset = ""
    ticket = ""
  }
}