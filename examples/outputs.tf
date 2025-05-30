// Copyright (c) 2018, 2025, Oracle and/or its affiliates.
// Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl

output "iam_compartment" {
  description = "compartment name, description, ocid, and parent ocid"
  value = {
    name        = module.iam_compartment.compartment_name,
    description = module.iam_compartment.compartment_description,
    ocid        = module.iam_compartment.compartment_id,
    parent      = module.iam_compartment.parent_compartment_id
  }
}

output "iam_subcompartment1" {
  description = "compartment name, description, ocid, and parent ocid"
  value = {
    name        = module.iam_subcompartment1.compartment_name,
    description = module.iam_subcompartment1.compartment_description,
    ocid        = module.iam_subcompartment1.compartment_id,
    parent      = module.iam_subcompartment1.parent_compartment_id
  }
}

output "iam_subcompartment2" {
  description = "compartment name, description, ocid, and parent ocid"
  value = {
    name        = module.iam_subcompartment2.compartment_name,
    description = module.iam_subcompartment2.compartment_description,
    ocid        = module.iam_subcompartment2.compartment_id,
    parent      = module.iam_subcompartment1.parent_compartment_id
  }
}
output "iam_users" {
  description = "list of username and associated ocid"
  value       = module.iam_users.name_ocid
}

output "iam_group" {
  description = "group name and associated ocid"
  value       = module.iam_group.name_ocid
}

output "iam_dynamic_group_name" {
  description = "dynamic group name and associated ocid"
  value       = module.iam_dynamic_group.name_ocid
}

output "compartment_ids_under_root" {
  description = "Compartment id list under root"
  value       = module.Hierarchical_compartment.compartment_ids
}
