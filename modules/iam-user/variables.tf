// Copyright (c) 2018, 2021, Oracle and/or its affiliates.

variable "tenancy_ocid" {
  type        = string
  description = "The OCID of the tenancy."
  default     = null
}

variable "users" {
  description = "The name and description you assign to the user during creation. The name must be unique across all compartments in the tenancy. "
  type = list(object({
    name        = string
    description = string
    email       = string
  }))
  default = null
}
