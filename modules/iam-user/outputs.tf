// Copyright (c) 2018, 2025, Oracle and/or its affiliates.
// Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl

output "name_ocid" {
  value       = zipmap(oci_identity_user.this[*].name, oci_identity_user.this[*].id)
  description = "list of username and associated OCID"
}

output "names" {
  value       = oci_identity_user.this[*].name
  description = "list of usernames"
}

output "user_description" {
  value       = oci_identity_user.this[*].description
  description = "list of users descriptions"
}

output "user_id" {
  value       = oci_identity_user.this[*].id
  description = "list of users OCID"
}