output "vpc_id" {
    description = "VPC ID"
    value = data.aws_vpc.vpc.id
}

output "public_subnet_id" {
    description = "Public Subnet ID"
    value = data.aws_subnet.public_subnet.id
}

output "sg_id" {
    description = "EC2 Security Group ID"
    value = data.aws_security_group.sg.id
}