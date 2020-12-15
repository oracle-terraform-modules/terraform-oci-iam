// Copyright (c) 2020, Oracle and/or its affiliates. All rights reserved.

output "dynamic_group_id" {
  value = var.dynamic_group_create ? element(concat(oci_identity_dynamic_group.this.*.id, list("")), 0) : lookup(local.dynamic_group_ids[0], "id")
}

output "dynamic_group_name" {
  value = var.dynamic_group_name
}

output "name_ocid" {
  value       = zipmap(oci_identity_dynamic_group.this[*].name, oci_identity_dynamic_group.this[*].id)
  description = "group name and associated OCID"
}
output "dynamic_group_policy_name" {
  value = var.policy_name
}
