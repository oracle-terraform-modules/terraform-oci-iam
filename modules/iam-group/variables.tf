// Copyright (c) 2018, Oracle and/or its affiliates. All rights reserved.

variable "tenancy_ocid" {
  description = "The OCID of the tenancy. "
}

variable "group_name" {
  description = "The name you assign to the group during creation. The name must be unique across all compartments in the tenancy. "
}

// The description is only used if group_create = true.
variable "group_description" {
  description = "The description you assign to the Group. Does not have to be unique, and it's changeable. "
  default     = ""
}

variable "group_create" {
  description = "Create the group or not. If true, the user must have permissions to create the group; If false, group data will be returned about the group if it exists, if not found, then an empty string will be returned for the group ID."
  default     = true
}

variable "user_count" {
  description = "Number of user(s) to be added in a group. "
  default     = 0
}

variable "user_ids" {
  description = "List of user' ocids. "
  default     = []
}

variable "policy_name" {
  description = "The name you assign to the policy during creation.  "
  default     = ""
}

variable "policy_description" {
  description = "The description you assign to the policy. Does not have to be unique, and it's changeable. "
  default     = ""
}

variable "policy_statements" {
  description = "Define policy consists of one or more policy statements. "
  default     = []
}

variable "policy_compartment_id" {
  description = "The compartment id assign to policy."
  default     = ""
}