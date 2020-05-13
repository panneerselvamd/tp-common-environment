locals {
  _vpc_cidrs = {
      wf1 = 19
  }

  vpc_cidr = "172.${local._vpc_cidrs[var.metadata["datacenter"]]}.0.0/16"
}

output "mongo_eip" {
    description = "Mongo Elastic IP"
    value = ["${module.ec2mongo.eip}"]
}
