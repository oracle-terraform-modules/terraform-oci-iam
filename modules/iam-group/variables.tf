// Copyright (c) 2018, 2021, Oracle and/or its affiliates.

variable "tenancy_ocid" {
  type = string
  description = "The OCID of the tenancy."
  default = null
}

variable "group_name" {
  type = string
  description = "The name you assign to the group during creation. The name must be unique across all compartments in the tenancy."
  default = null
}

// The description is only used if group_create = true.
variable "group_description" {
  type = string
  description = "The description you assign to the Group. Does not have to be unique, and it's changeable. "
  default     = null
}

variable "group_create" {
  type = bool
  description = "(Deprecated) Create the group or not. If true, the user must have permissions to create the group; If false, group data will be returned about the group if it exists, if not found, then an empty string will be returned for the group ID."
  default     = true
}

variable "user_ids" {
  type = list(string)
  description = "List of user ocids to be added as group member"
  default     = null
}

variable "policy_name" {
  type = string
  description = "The name you assign to the policy during creation.  "
  default     = null
}

variable "policy_description" {
  type = string
  description = "The description you assign to the policy. Does not have to be unique, and it's changeable. "
  default     = null
}

variable "policy_statements" {
  type = list(string)
  description = "Define policy consists of one or more policy statements. "
  default     = null
}

variable "policy_compartment_id" {
  type = string
  description = "The compartment id where policy is created."
  default     = null
}