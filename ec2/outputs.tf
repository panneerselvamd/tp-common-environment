output "eip" {
    description = "Public IPs"
    value = ["${module.ec2.eip}"]
}

output "instance_id" {
    description = "EC2 instance IDs"
    value = ["${module.ec2.instance_id}"]
}

output "private_ip" {
    description = "Private IPs"
    value = ["${module.ec2.private_ip}"]
}

output "instance_name" {
    description = "EC2 Instance Name"
    value = ["${module.ec2.instance_name}"]
}