provider "aws" {
    region = "us-east-2"
}

module "jumphost_comp" {
  source = "./jumphost"
  metadata = var.metadata
}

module "mongodb_comp" {
  source = "./mongodb"
  metadata = var.metadata
}