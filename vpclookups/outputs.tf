output "vpc_id" {
    description = "VPC ID"
    value = data.aws_vpc.vpc.id
}

output "subnet_id" {
    description = "Subnet ID"
    value = data.aws_subnet.subnet.id
}

output "sg_id" {
    description = "EC2 Security Group ID"
    value = data.aws_security_group.sg.id
}