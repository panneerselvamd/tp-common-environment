locals {
  _vpc_cidrs = {
      wf1 = 19
  }

  vpc_cidr = "172.${local._vpc_cidrs[var.metadata["datacenter"]]}.0.0/16"

  private_subnets = {
      "A" = "172.${local._vpc_cidrs[var.metadata["datacenter"]]}.1.0/24"
      "B" = "172.${local._vpc_cidrs[var.metadata["datacenter"]]}.2.0/24"
      "C" = "172.${local._vpc_cidrs[var.metadata["datacenter"]]}.3.0/24"
  }

  private_subnet_cidr = local.private_subnets[var.availability_zone]
  public_subnet_cidr = "172.${local._vpc_cidrs[var.metadata["datacenter"]]}.0.0/24"
}