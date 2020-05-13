variable "tier_nb" {
  description = "tier in which data lookups will be run: 1, 2 or 3"
  type = string
  default = "1"
}

variable "metadata" {
  description = "Auto-generated values. Map of well known values passed by the automation itself: env_subtype external_segment, internal_segment, component, datacenter"
  type = map
}

variable "availability_zone" {
  description = "Availability Zone to create resources"
  type = string
  default = "A"
}