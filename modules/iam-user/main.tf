// Copyright (c) 2018, Oracle and/or its affiliates. All rights reserved.

########################
# User
########################
resource "oci_identity_user" "this" {
  count          = length(var.users)
  compartment_id = var.tenancy_ocid
  name           = var.users[count.index].name
  description    = var.users[count.index].description
  email          = var.users[count.index].email
  freeform_tags = {
    "Terraformed" = "Yes"
    "TF_Module"   = "iam_iam-user"
  }
}

