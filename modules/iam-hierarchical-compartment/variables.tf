// Copyright (c) 2018, 2021, 2025, Oracle and/or its affiliates.
// Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl


variable "compartments" {
  type        = any
  description = "Hierarchical Compartments"
}

variable "root_compartment_id" {
  type        = string
  description = "Target compartment id which is considered as root"
}
