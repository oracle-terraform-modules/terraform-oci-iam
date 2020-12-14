// Copyright (c) 2020, Oracle and/or its affiliates. All rights reserved.

output "name_ocid" {
  value       = zipmap(oci_identity_user.this[*].name, oci_identity_user.this[*].id)
  description = "list of username and associated OCID"
}

output "names" {
  value       = oci_identity_user.this[*].name
  description = "list of usernames"
}

output "user_id" {
  value       = oci_identity_user.this[*].id
  description = "list of users OCID"
}