// Copyright (c) 2018, Oracle and/or its affiliates. All rights reserved.

########################
# Compartment
########################

resource "oci_identity_compartment" "this" {
  count          = "${var.compartment_create ? 1 : 0}"
  compartment_id = "${var.tenancy_ocid}"
  name           = "${var.compartment_name}"
  description    = "${var.compartment_description}"
}

data "oci_identity_compartments" "this" {
  count          = "${var.compartment_create ? 0 : 1}"
  compartment_id = "${var.tenancy_ocid}"

  filter {
    name   = "name"
    values = ["${var.compartment_name}"]
  }
}

locals {
  compartment_ids = "${concat(flatten(data.oci_identity_compartments.this.*.compartments), list(map("id", "")))}"
}
