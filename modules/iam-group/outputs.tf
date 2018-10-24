// Copyright (c) 2018, Oracle and/or its affiliates. All rights reserved.

output "group_id" {
  value = "${var.group_create ? element(concat(oci_identity_group.this.*.id, list("")), 0) : lookup(local.group_ids[0], "id") }"
}

output "group_name" {
  value = "${var.group_name}"
}

output "group_policy_name" {
  value = "${var.policy_name}"
}
