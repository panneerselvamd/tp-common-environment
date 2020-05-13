variable "jumphost" {
  type = map
  default = {
      "count" = "1"
      "ssh_pub_developer" = "ssh-rsa"
      "instance_type" = "t2.micro"
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
    component = "jumphost"
    component_kv_store = ""
    vault_addr = ""
    vpc_offset = ""
    ticket = ""
  }
}