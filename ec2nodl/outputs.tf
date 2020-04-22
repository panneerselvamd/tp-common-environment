output "eip" {
    description = "Public IPs"
    value = ["${aws_eip.eip.*.public_ip}"]
}

output "instance_id" {
    description = "EC2 instance IDs"
    value = ["${aws_instance.instance.*.id}"]
}

output "private_ip" {
    description = "Private IPs"
    value = ["${aws_instance.instance.*.private_ip}"]
}

output "instance_name" {
    description = "EC2 Instance Name"
    value = ["${aws_instance.instance.*.tags.Name}"]
}