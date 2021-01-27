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
# Compartment
########################

resource "oci_identity_compartment" "this" {
  count          = var.compartment_create ? 1 : 0
  compartment_id = var.compartment_id != null ? var.compartment_id : var.tenancy_ocid
  name           = var.compartment_name
  description    = var.compartment_description
  enable_delete  = var.enable_delete
}

data "oci_identity_compartments" "this" {
  count          = var.compartment_create ? 0 : 1
  compartment_id = var.compartment_id

  filter {
    name   = "name"
    values = [var.compartment_name]
  }
}

locals {
  compartment_ids        = concat(flatten(data.oci_identity_compartments.this.*.compartments), list(map("id", "")))
  parent_compartment_ids = concat(flatten(data.oci_identity_compartments.this.*.compartments), list(map("compartment_id", "")))
}
