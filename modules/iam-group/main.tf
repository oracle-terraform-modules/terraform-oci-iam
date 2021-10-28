// Copyright (c) 2018, 2021, Oracle and/or its affiliates.

terraform {
  required_version = ">= 0.12" // terraform version below 0.12 is not tested/supported with this module
  required_providers {
    oci = {
      version = ">= 3.27" // force downloading oci-provider compatible with terraform v0.12
    }
  }
}

########################
# Group
########################
resource "oci_identity_group" "this" {
  count          = var.group_create == true ? 1 : 0
  compartment_id = var.tenancy_ocid
  name           = var.group_name
  description    = var.group_description
}

data "oci_identity_groups" "this" {
  count          = var.group_create == false ? 1 : 0
  compartment_id = var.tenancy_ocid

  filter {
    name   = "name"
    values = [var.group_name]
  }
}

locals {
  group_ids = concat(flatten(data.oci_identity_groups.this.*.groups), list(map("id", "")))
}

########################
# Add user to a group
########################
resource "oci_identity_user_group_membership" "this" {
  count    = var.user_ids == null ? 0 : length(var.user_ids)
  user_id  = var.user_ids[count.index]
  group_id = var.group_create ? element(concat(oci_identity_group.this.*.id, list("")), 0) : lookup(local.group_ids[0], "id")
}

########################
# Group Policy
########################
resource "oci_identity_policy" "this" {
  count          = var.policy_name != null ? 1 : 0
  depends_on     = [oci_identity_group.this]
  name           = var.policy_name
  description    = var.policy_description
  compartment_id = var.policy_compartment_id
  statements     = var.policy_statements
}

########################
# Add idp_mapping to a group
########################

resource "oci_identity_idp_group_mapping" "this" {
  count                = var.idp_provider_id == null ? 0 : length(var.idp_provider_id)
  group_id             = var.group_create ? element(concat(oci_identity_group.this.*.id, list("")), 0) : lookup(local.group_ids[0], "id")
  identity_provider_id = var.idp_provider_id
  idp_group_name       = var.idp_group_name
}
