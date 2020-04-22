variable "jumphost" {
  type = map
  default = {
      "count" = "1"
      "ssh_pub_developer" = "ssh-rsa"
      "instance_type" = "t2.micro"
      "eip_enabled" = "true"
  }
}

variable "metadata" {}