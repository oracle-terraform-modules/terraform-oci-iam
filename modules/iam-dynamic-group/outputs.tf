// Copyright (c) 2018, 2021, Oracle and/or its affiliates.

output "dynamic_group_id" {
  description = "Dynamic Group ocid"
  value       = var.dynamic_group_create ? element(concat(oci_identity_dynamic_group.this.*.id, [""]), 0) : lookup(local.dynamic_group_ids[0], "id")
}

output "dynamic_group_name" {
  description = "Dynamic Group name"
  value       = var.dynamic_group_name
}

output "name_ocid" {
  value       = zipmap(oci_identity_dynamic_group.this[*].name, oci_identity_dynamic_group.this[*].id)
  description = "Dynamic Group name and associated OCID"
}
output "dynamic_group_policy_name" {
  description = "Dynamic Group policy name"
  value       = var.policy_name
}
