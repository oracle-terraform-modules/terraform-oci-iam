// Copyright (c) 2020, Oracle and/or its affiliates. All rights reserved.

variable "tenancy_ocid" {
  description = "The OCID of the tenancy. "
}

variable "compartment_name" {
  description = "The name you assign to the compartment during creation. The name must be unique across all compartments in the tenancy. "
}

variable "compartment_id" {
  description = "The OCID of the parent compartment containing the compartment. Allow for sub-compartments creation"
  default     = ""
}

// The description is only used if compartment_create = true.
variable "compartment_description" {
  description = "The description you assign to the compartment. Does not have to be unique, and it's changeable. "
  default     = ""
}

variable "compartment_create" {
  description = "Create the compartment or not. If true, the compartment will be managed by this module, and the user must have permissions to create the compartment; If false, compartment data will be returned about the compartment if it exists, if not found, then an empty string will be returned for the compartment ID."
  default     = true
}

variable "enable_delete" {
  description = "Enable compartment delete on destroy. If true, compartment will be deleted when `terraform destroy` is executed; If false, compartment will not be deleted on `terraform destroy` execution"
  default     = false
}
