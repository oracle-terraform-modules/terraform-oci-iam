// Copyright (c) 2018, 2021, Oracle and/or its affiliates.

output "group_id" {
  description = "Group ocid"
  value       = var.group_create ? element(concat(oci_identity_group.this.*.id, [""]), 0) : lookup(local.group_ids[0], "id")
}

output "group_name" {
  description = "Group name"
  value       = var.group_name
}

output "name_ocid" {
  value       = zipmap(oci_identity_group.this[*].name, oci_identity_group.this[*].id)
  description = "group name and associated OCID"
}

output "group_description" {
  description = "Group description"
  value       = var.group_description
}

output "group_policy_name" {
  description = "Group policy name"
  value       = var.policy_name
}
