// Copyright (c) 2018, Oracle and/or its affiliates. All rights reserved.

########################
# Dynamic Group
########################
resource "oci_identity_dynamic_group" "this" {
  count          = var.dynamic_group_create ? 1 : 0
  compartment_id = var.tenancy_ocid
  name           = var.dynamic_group_name
  description    = var.dynamic_group_description
  matching_rule  = var.dynamic_group_rule
  freeform_tags = {
    "Terraformed" = "Yes"
    "TF_Module" = "iam_iam-dynamic-group"
  }
}

data "oci_identity_dynamic_groups" "this" {
  count          = var.dynamic_group_create ? 0 : 1
  compartment_id = var.tenancy_ocid

  filter {
    name   = "name"
    values = [var.dynamic_group_name]
  }
}

locals {
  dynamic_group_ids = "${concat(flatten(data.oci_identity_dynamic_groups.this.*.dynamic_groups), list(map("id", "")))}"
}

########################
# Dynamic Group Policy
########################
resource "oci_identity_policy" "this" {
  count          = length(var.policy_name) > 0 ? 1 : 0
  depends_on     = ["oci_identity_dynamic_group.this"]
  name           = var.policy_name
  description    = var.policy_description
  compartment_id = var.policy_compartment_id
  statements     = var.policy_statements
  freeform_tags = {
    "Terraformed" = "Yes"
    "TF_Module" = "iam_iam-dynamic-group"
  }
}
