// Copyright (c) 2018, Oracle and/or its affiliates. All rights reserved.

########################
# Group
########################
resource "oci_identity_group" "this" {
  count          = "${var.group_create ? 1 : 0}"
  compartment_id = "${var.tenancy_ocid}"
  name           = "${var.group_name}"
  description    = "${var.group_description}"
}

data "oci_identity_groups" "this" {
  count          = "${var.group_create ? 0 : 1}"
  compartment_id = "${var.tenancy_ocid}"

  filter {
    name   = "name"
    values = ["${var.group_name}"]
  }
}

locals {
  group_ids = "${concat(flatten(data.oci_identity_groups.this.*.groups), list(map("id", "")))}"
}

########################
# Add user to a group
########################
resource "oci_identity_user_group_membership" "this" {
  # terraform modules value of count cannot be computed
  # https://github.com/hashicorp/terraform/issues/12570
  # count    = "${length(var.user_ids)}"
  # use workaround here
  count = "${var.user_count}"

  user_id  = "${var.user_ids[count.index]}"
  group_id = "${var.group_create ? element(concat(oci_identity_group.this.*.id, list("")), 0) : lookup(local.group_ids[0], "id")}"
}

########################
# Group Policy
########################
resource "oci_identity_policy" "this" {
  count          = "${length(var.policy_name) > 0 ? 1 : 0}"
  depends_on     = ["oci_identity_group.this"]
  name           = "${var.policy_name}"
  description    = "${var.policy_description}"
  compartment_id = "${var.policy_compartment_id}"
  statements     = "${var.policy_statements}"
}
