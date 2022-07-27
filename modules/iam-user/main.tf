// Copyright (c) 2018, 2022, Oracle and/or its affiliates.

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

