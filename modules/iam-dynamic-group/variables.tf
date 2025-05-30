// Copyright (c) 2018, 2025, Oracle and/or its affiliates.
// Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl


variable "tenancy_ocid" {
  type = string
  description = "The OCID of the tenancy."
  default = null
}

variable "dynamic_group_name" {
  type = string
  description = "The name you assign to the group during creation. The name must be unique across all compartments in the tenancy. "
  default = null
}

variable "dynamic_group_description" {
  type = string
  description = "The description you assign to the Group. Does not have to be unique, and it's changeable. "
  default     = null
}

variable "dynamic_group_create" {
  type = bool
  description = "(Deprecated) Create the dynamic group or not. If true, the user must have permissions to create the group; If false, group data will be returned about the group if it exists, if not found, then an empty string will be returned for the group ID."
  default     = true
}

variable "matching_rule" {
  type = string
  description = "Define a matching rule or a set of matching rules to define the group members."
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
  description = "The compartment id assign to policy."
  default     = null
}
