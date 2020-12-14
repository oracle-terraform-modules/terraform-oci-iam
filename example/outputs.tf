// Copyright (c) 2020, Oracle and/or its affiliates. All rights reserved.

output "compartment_name" {
  value = module.iam_compartment.compartment_name
}

output "compartment_id" {
  value = module.iam_compartment.compartment_id
}

output "subcompartment_name" {
  value = module.iam_subcompartment.compartment_name
}

output "subcompartment_id" {
  value = module.iam_subcompartment.compartment_id
}

output "iam_users" {
  value       = module.iam_users[*].name_ocid
  description = "list of username and associated ocid"
}

output "iam_group_name" {
  value = "${module.iam_group.group_name}"
}

output "iam_dynamic_group_name" {
  value = "${module.iam_dynamic_group.dynamic_group_name}"
}