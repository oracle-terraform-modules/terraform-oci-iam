// Copyright (c) 2020, Oracle and/or its affiliates. All rights reserved.

variable "tenancy_ocid" {
  description = "The OCID of the tenancy. "
}

variable users {
  description = "The name and description you assign to the user during creation. The name must be unique across all compartments in the tenancy. "
  default = [
    {
      name        = null
      description = null
      email       = null
    }
  ]
}

