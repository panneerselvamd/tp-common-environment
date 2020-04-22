variable "tier_nb" {
  description = "tier in which data lookups will be run: 1, 2 or 3"
  type = string
}

variable "metadata" {
  description = "Auto-generated values. Map of well known values passed by the automation itself: env_subtype external_segment, internal_segment, component, datacenter"
  type = map
}
