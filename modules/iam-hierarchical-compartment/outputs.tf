// Copyright (c) 2018, 2025, Oracle and/or its affiliates.
// Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl


locals {
  compartment_ids = merge(concat(
    [for entry in local.compartment_level_1 : {
    (entry.compartment_name) = oci_identity_compartment.compartment_level_1[entry.compartment_name].id }],
    [for entry in local.compartment_level_2 : {
    (join("/", [entry.parent_compartment, entry.compartment_name])) = oci_identity_compartment.compartment_level_2["${entry.parent_compartment}/${entry.compartment_name}"].id }],
    [for entry in local.compartment_level_3 : {
    (join("/", [entry.parent_compartment, entry.compartment_name])) = oci_identity_compartment.compartment_level_3["${entry.parent_compartment}/${entry.compartment_name}"].id }],
    [for entry in local.compartment_level_4 : {
    (join("/", [entry.parent_compartment, entry.compartment_name])) = oci_identity_compartment.compartment_level_4["${entry.parent_compartment}/${entry.compartment_name}"].id }],
    [for entry in local.compartment_level_5 : {
    (join("/", [entry.parent_compartment, entry.compartment_name])) = oci_identity_compartment.compartment_level_5["${entry.parent_compartment}/${entry.compartment_name}"].id }],
    [for entry in local.compartment_level_6 : {
  (join("/", [entry.parent_compartment, entry.compartment_name])) = oci_identity_compartment.compartment_level_6["${entry.parent_compartment}/${entry.compartment_name}"].id }])...)
}

output "compartment_ids" {
  value       = local.compartment_ids
  description = "Compartment ID's"
}
