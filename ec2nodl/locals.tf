locals {
  ami_name_regex = "${var.ami_name_regex == "" ? "^SCB-RHEL[78][-.]2*." : var.ami_name_regex}"
  instance_type = "${var.instance_type == "" ? "t2.micro" : var.instance_type}"
  root_volume_size = "${var.root_volume_size == "" ? "10" : var.root_volume_size}"
  eip_enabled = "${var.eip_enabled ? "1" : "0"}"
  data_volume_count = "${var.data_volume_enabled == "0" || var.data_volume_enabled == "" ? "0" : var.counter}"
  attach_labeled_volume_count = "${var.attach_labeled_volumes == "" ? "0" : var.counter}"
  attach_labeled_volume_seed = "${var.attach_labeled_volumes == "true" ? var.short_name : var.attach_labeled_volumes}"
  tags = "${
        merge(
            map(
                "Name", "to-be-overwritten-with-actual-instance-count",
                "component", "${var.metadata["component"]}",
                "env_subtype", "${var.metadata["env_subtype"]}"
            ),
            var.custom_tags
        )
    }"

}