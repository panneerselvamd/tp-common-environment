data "aws_ami" "ami" {
    most_recent = true
    //name_regex = local.ami_name_regex
    owners = ["amazon"]
    filter {
        name = "image-id"
        values = ["ami-0f7919c33c90f5b58"]
    }
}

resource "aws_network_interface" "eni" {
    count = var.counter
    subnet_id = var.subnet_id
    security_groups = var.sg_ids
    tags = {
        _ReservedDnsName = "${format("${var.short_name}%02d-%s", count.index, var.metadata["datacenter"])}"
    }
}

resource "aws_instance" "instance" {
    ami = data.aws_ami.ami.id
    instance_type = local.instance_type
    count = var.counter
    network_interface {
        device_index = 0
        network_interface_id = aws_network_interface.eni.*.id[count.index]
    }
    user_data = var.custom_userdata
    tags = merge(
            local.tags,
            map(
                "Name", "${format("${var.short_name}%02d-%s", count.index, var.metadata["datacenter"])}"
            ))

    root_block_device {
        volume_type = "gp2"
        volume_size = local.root_volume_size
    }
    key_name = "deployer-key"
}

resource "aws_eip" "eip" {
    count = local.eip_enabled ? var.counter : 0
    vpc = true
    instance = aws_instance.instance.*.id[count.index]
}

resource "aws_eip_association" "eip_assoc" {
    count = local.eip_enabled ? var.counter : 0
    instance_id = aws_instance.instance.*.id[count.index]
    allocation_id = aws_eip.eip.*.id[count.index]
}

#Create EBS Volume
resource "aws_ebs_volume" "volume-data" {
    count = local.data_volume_count
    size = var.data_volume_size
    type = var.data_volume_type
    availability_zone = "us-east-2b"
    tags = {
        Name = "${var.short_name}-${count.index}-data"
    }
}

resource "aws_volume_attachment" "volume-data-attachment" {
    count = local.data_volume_count
    device_name = var.data_device_name
    volume_id = aws_ebs_volume.volume-data.*.id[count.index]
    instance_id = aws_instance.instance.*.id[count.index]
    /*lifecycle {
        ignore_changes = [volume_tags, aws_instance, aws_ebs_volume]
    }*/
}

#Attach an Existing EBS Volume
data "aws_ebs_volume" "existing_volume" {
    count = local.attach_labeled_volume_count
    most_recent = true

    filter {
        name = "tag:label"
        values = ["${format("%s%02d", local.attach_labeled_volume_seed, count.index)}"]
    }
}

resource "aws_volume_attachment" "labeled_volume_attachment" {
    count = local.attach_labeled_volume_count
    device_name = var.data_device_name
    volume_id = data.aws_ebs_volume.existing_volume.*.id[count.index]
    instance_id = aws_instance.instance.*.id[count.index]
    /*lifecycle {
        ignore_changes = [volume_tags, aws_ebs_volume]
    }*/
}
