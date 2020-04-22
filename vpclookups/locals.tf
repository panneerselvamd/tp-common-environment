locals {
  _vpc_cidrs = {
      wf1 = 19
  }

  vpc_cidr = "172.${local._vpc_cidrs[var.metadata["datacenter"]]}.0.0/16"

  subnet_cidrs = {
      "1" = "172.${local._vpc_cidrs[var.metadata["datacenter"]]}.0.0/20"
  }

  subnet_cidr = "${local.subnet_cidrs[var.tier_nb]}"
}