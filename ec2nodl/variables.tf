variable "ami_name_regex" {
  description = "Select the latest AMI"
  default = "ami-0f7919c33c90f5b58"
}

variable "custom_userdata" {
  description = "custom_userdata or empty for nothing"
  default = ""
}

variable "counter" {
  description = "Number of instances to create"
  default = "1"
}

variable "subnet_id" {
  description = "ID of the Subnet to create ENI"
}

variable "sg_ids" {
  description = "List of security group IDs to attach to this Instance"
  type = list
}

variable "short_name" {
  description = "seed the name of VM"
  default = "vm"
}

variable "metadata" {
  description = "Map of well known values passed by the automation"
  type = map
}

variable "instance_type" {
  description = "Instance type. computed to t2.micro by default"
  default = ""
}

variable "custom_tags" {
  description = "additional tags"
  type = map
  default = {}
}

variable "root_volume_size" {
  description = "Size in GB of the root volume"
  default = ""
}

variable "eip_enabled" {
  description = "True to associate an Elastic IP"
  default = false
}

variable "data_volume_enabled" {
  description = "Flag to enable additional EBS to instance"
  default = "0"
}

variable "data_volume_size" {
  description = "Size of EBS to be attached to the instance"
  default = "10"
}

variable "data_volume_type" {
  description = "Type of EBS"
  default = "gp2"
}

variable "data_device_name" {
  description = "Device name to use"
  default = "/dev/vdb"
}

variable "attach_labeled_volumes" {
  description = "When not empty, will attach to each instance"
  default = ""
}
