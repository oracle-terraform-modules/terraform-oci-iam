// Copyright (c) 2018, 2025, Oracle and/or its affiliates.
// Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl

variable "tenancy_ocid" {
  type = string
  description = "The OCID of the tenancy."
  default = null
}

variable users {
  description = "The name and description you assign to the user during creation. The name must be unique across all compartments in the tenancy. "
  type = list(object({
    name = string
    description = string
    email = string
  }))
  default = null
}
