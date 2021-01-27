// Copyright (c) 2018, 2021, Oracle and/or its affiliates.

output "compartment_id" {
  // This allows the compartment ID to be retrieved from the resource if it exists, and if not to use the data source.
  value = var.compartment_create ? element(concat(oci_identity_compartment.this.*.id, list("")), 0) : lookup(local.compartment_ids[0], "id")
}

output "parent_compartment_id" {
  // This allows the compartment ID to be retrieved from the resource if it exists, and if not to use the data source.
  value = var.compartment_create ? element(concat(oci_identity_compartment.this.*.compartment_id, list("")), 0) : lookup(local.parent_compartment_ids[0], "compartment_id")
}

output "compartment_name" {
  value = var.compartment_name
}

output "compartment_description" {
  value = var.compartment_description
}
