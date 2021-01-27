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
# User
########################
resource "oci_identity_user" "this" {
  count          = length(var.users)
  compartment_id = var.tenancy_ocid
  name           = var.users[count.index].name
  description    = var.users[count.index].description
  email          = var.users[count.index].email == null ? "" : var.users[count.index].email
}

